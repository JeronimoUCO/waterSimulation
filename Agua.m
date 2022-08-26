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
##  v(j+1)=g-b*v(j)+v(j);%Es el vector de velocidad
##  posicionx=abs(floor(posicionx+v(j+1)*(sin(anguloLanzamiento))-vViento));
##  posiciony=abs(floor(posiciony+v(j+1)*(cos(anguloLanzamiento))));
##endif
##
##if(posicionx>=200 || posiciony>=200 || posicionx<=1 || posiciony<=1)
##  v(j)=-v(j);
##  v(j+1)= -b*v(j)+v(j)+g;%Es el vector de velocidad
##   if(posiciony>=200)
##   posiciony=200;
##    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento)))-vViento);
##    posiciony=abs(floor(posiciony+v(j+1)*(cos(anguloLanzamiento))));
##
##    if(posicionx>=200)
##    posiciony=200;
##    posicionx=abs(floor(posicionx+v(j+1)*cos(anguloLanzamiento)+vViento));
##    posiciony=abs(floor(posiciony-v(j+1)*sin(anguloLanzamiento)));
##    estaSubiendo=true;
##  endif
##
##  if(posicionx<1)
##    posiciony=1;
##    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento)))-vViento);
##    posiciony=abs(floor(posiciony-v(j+1)*(cos(anguloLanzamiento))));
##endif
##
##  if(posiciony<1)
##    posicionx=1;
##    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento)))-vViento);
##    posiciony=abs(floor(posiciony-v(j+1)*(cos(anguloLanzamiento))));
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
global nParticulas;
global particulas;
recipiente = zeros(200, 200);
nParticulas= 0;
tiempoMuestreo = 0.1;
velocidadViento = 1;
b = 0.05;
g = 9.82;

function crearParticula()
    global nParticulas;
    global particulas;
    p = struct();
    p.v(1) = 0;
    p.estaSubiendo = false;
    p.posicionx = 1;
    p.posiciony = 1;

    nParticulas+=1;
    particulas(nParticulas) = p;
endfunction

function dibujarPantalla(instante)
    global particulas;
    for i = 1:rows(particulas)

        if (!particulas(i).estaSubiendo)
            particulas(i).v(intante + 1) = g - b * particulas(i).v(j) + particulas(i).v(j); %Es el vector de velocidad
            particulas(i).posicionx = abs(floor(particulas(i).posicionx - vViento));
            particulas(i).posiciony = abs(floor(particulas(i).posiciony + particulas(i).v(j + 1)));
            endif;

            if (particulas(i).posicionx >= 200 || particulas(i).posiciony >= 200 || particulas(i).posicionx <= 1 || particulas(i).posiciony <= 1)
                particulas(i).v(j)=-particulas(i).v(j);
                particulas(i).v(j+1)= -b*particulas(i).v(j)+particulas(i).v(j)+g;%Es el vector de velocidad
                
                if(particulas(i).posiciony>=200)
                particulas(i).posiciony=200;
                particulas(i).posicionx=abs(floor(particulas(i).posicionx-v(j+1))-vViento);
                particulas(i).posiciony=abs(floor(particulas(i).posiciony+v(j+1)));
                endif

                if(particulas(i).posicionx>=200)
                particulas(i).posiciony=200;
                particulas(i).posicionx=abs(floor(particulas(i).posicionx+v(j+1)+vViento));
                particulas(i).posiciony=abs(floor(particulas(i).posiciony-v(j+1)));
                particulas(i).estaSubiendo=true;
                endif
                
                if(particulas(i).posicionx<1)
                particulas(i).posiciony=1;
                particulas(i).posicionx=abs(floor(particulas(i).posicionx-v(j+1))-vViento);
                particulas(i).posiciony=abs(floor(particulas(i).posiciony-v(j+1)));
                endif
            endif

            recipiente(particulas(i).posicionx,particulas(i).posiciony)=255;
            endfor
            imshow(recipiente)
            for i = 1:rows(particulas)
                recipiente(particulas(i).posicionx,particulas(i).posiciony)=0;
            endfor
            imshow(recipiente)
        endfunction

for i=1:100
    crearParticula();
    dibujarPantalla(i);
endfor