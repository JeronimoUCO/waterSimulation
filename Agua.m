##clear all
##
##close all
##
###Creo las matrices constantes
##global g;
##global a;
##global posiciones;
##global vViento;
##global b;
##
##a=zeros(200,200);
##posiciones=zeros(20,2);
##
##posiciones(1,1)=50;
##posiciones(1,2)=50;
##posiciones(2,1)=10;
##posiciones(2,2)=20;
##posiciones(3,1)=30;
##posiciones(3,2)=200;
##
###Muestro el estado inicial del "recipiente"
##imshow(a)
##
###Defino el comportamiento de las particulas
##function particula(iterador, posicionx, posiciony)
##  vViento=10;
##  g=9.8;
##  b=0.05;
##  anguloLanzamiento=45/180;
##  v(1)=0;
##  estaSubiendo=false;
##  j=iterador;
##
##  if(!estaSubiendo)
##  v(instante+1)=g-b*v(instante)+v(instante);%Es el vector de velocidad
##  posicionx=abs(floor(posicionx+v(instante+1)*(sin(anguloLanzamiento))-vViento));
##  posiciony=abs(floor(posiciony+v(instante+1)*(cos(anguloLanzamiento))));
##endif
##
##if(posicionx>=200 || posiciony>=200 || posicionx<=1 || posiciony<=1)
##  v(instante)=-v(instante);
##  v(instante+1)= -b*v(instante)+v(instante)+g;%Es el vector de velocidad
##   if(posiciony>=200)
##   posiciony=200;
##    posicionx=abs(floor(posicionx-v(instante+1)*(sin(anguloLanzamiento)))-vViento);
##    posiciony=abs(floor(posiciony+v(instante+1)*(cos(anguloLanzamiento))));
##
##    if(posicionx>=200)
##    posiciony=200;
##    posicionx=abs(floor(posicionx+v(instante+1)*cos(anguloLanzamiento)+vViento));
##    posiciony=abs(floor(posiciony-v(instante+1)*sin(anguloLanzamiento)));
##    estaSubiendo=true;
##  endif
##
##  if(posicionx<1)
##    posiciony=1;
##    posicionx=abs(floor(posicionx-v(instante+1)*(sin(anguloLanzamiento)))-vViento);
##    posiciony=abs(floor(posiciony-v(instante+1)*(cos(anguloLanzamiento))));
##endif
##
##  if(posiciony<1)
##    posicionx=1;
##    posicionx=abs(floor(posicionx-v(instante+1)*(sin(anguloLanzamiento)))-vViento);
##    posiciony=abs(floor(posiciony-v(instante+1)*(cos(anguloLanzamiento))));
##
##  endif
## endif
##endif
## if(v<=0 & estaSubiendo)
## estaSubiendo=false;
##endif
##
##a(posiciony,posicionx)=255;
##imshow(a);
##pause(0.0001);
##a(posiciony,posicionx)=0;
##endfunction
##
##for i=1:100
## %i es el espacio que recorro en el eje y
## for r=1:length(posiciones)
##   particula(i,posiciones(r,1),posiciones(r,2))
##   endfor
##endfor

#Variables globales
global nParticulas;
global particulas;
global recipiente;
global g;
global b;
global vViento;
global nParticulas;
global tiempoMuestreo;
global render;
global nFotograma;

particulas=struct();
render={};
nFotograma=1;
recipiente = zeros(200, 200);
nParticulas= 1;
tiempoMuestreo = 0.0000001;
vViento = 1;
b = 0.05;
g = 9.82;

#Funcion que permite la creacion de particulas
function crearParticula()
    global nParticulas;
    global particulas;
    particulas(nParticulas).v(1) = 1;
    particulas(nParticulas).estaSubiendo = false;
    particulas(nParticulas).posicionx = 1;
    particulas(nParticulas).posiciony = 1;
    nParticulas+=1;
endfunction

#Funcion que muestra lo que está sucediendo en el recipiente en un instante determinado
function dibujarPantalla(instante)
    global particulas;
    global g;
    global b;
    global vViento;
    global recipiente;
    global tiempoMuestreo;
    global render;
    global nFotograma;

    for i = 1:columns(particulas)
        if (!particulas(i).estaSubiendo)
            particulas(i).v(instante+1) = g - b * particulas(i).v(instante) + particulas(i).v(instante); %Es el vector de velocidad
            particulas(i).posicionx = abs(floor(particulas(i).posicionx - vViento));
            particulas(i).posiciony = abs(floor(particulas(i).posiciony + particulas(i).v(instante+1)));
            endif;

            if (particulas(i).posicionx >= 200 || particulas(i).posiciony >= 200 || particulas(i).posicionx <= 1 || particulas(i).posiciony <= 1)
                particulas(i).v(instante)=-particulas(i).v(instante);
                particulas(i).v(instante+1)= -b*particulas(i).v(instante)+particulas(i).v(instante)+g;%Es el vector de velocidad

                if(particulas(i).posiciony>=200)
                particulas(i).posiciony=200;
                particulas(i).posicionx=abs(floor(particulas(i).posicionx-particulas(i).v(instante+1))-vViento);
                particulas(i).posiciony=abs(floor(particulas(i).posiciony+particulas(i).v(instante+1)));
                endif

                if(particulas(i).posicionx>=200)
                particulas(i).posiciony=200;
                particulas(i).posicionx=abs(floor(particulas(i).posicionx+particulas(i).v(instante+1)+vViento));
                particulas(i).posiciony=abs(floor(particulas(i).posiciony-particulas(i).v(instante+1)));
                particulas(i).estaSubiendo=true;
                endif

                if(particulas(i).posicionx<=1)
                particulas(i).posiciony=1;
                particulas(i).posicionx=abs(floor(particulas(i).posicionx-particulas(i).v(instante+1))-vViento);
                particulas(i).posiciony=abs(floor(particulas(i).posiciony-particulas(i).v(instante+1)));
                endif
            endif
        endfor
        for r=1:columns(particulas)
           recipiente(particulas(r).posiciony,particulas(r).posicionx)=255;
        endfor
        render{nFotograma}=recipiente;
        nFotograma+=1;
        for i = 1:columns(particulas)
            recipiente(particulas(r).posiciony,particulas(r).posicionx)=0;
        endfor
        render{nFotograma}=recipiente;
        nFotograma+=1;
        endfunction

#Programa en funcionamiento
for i=1:100
crearParticula();
endfor

for i=1:1000
    dibujarPantalla(i);
endfor

for i=1:columns(render)
imshow(render{i});
pause(tiempoMuestreo);
endfor