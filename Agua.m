clear all

close all

#Creo las matrices constantes
global g;
global a;
global posiciones;
global vViento;
global b;

a=zeros(200,200);
posiciones=zeros(20,2);

#Muestro el estado inicial del "recipiente"
imshow(a)

#Instancio las variables globales
vViento=10;
g=9.8;
b=0.05;


#Defino el comportamiento de las particulas
function particula(iterador, posicionx, posiciony)
  anguloLanzamiento=45/180;
  v(1)=0;
  estaSubiendo=false;
  j=iterador

  if(!estaSubiendo)
  v(j+1)=g-b*v(j)+v(j);%Es el vector de velocidad
  posicionx=abs(floor(posicionx+v(j+1)*(sin(anguloLanzamiento))-vViento));
  posiciony=abs(floor(posiciony+v(j+1)*(cos(anguloLanzamiento))));
endif
if(posicionx>=200 || posiciony>=200 || posicionx<=1 || posiciony<=1)
  v(j)=-v(j);
  v(j+1)= -b*v(j)+v(j)+g;%Es el vector de velocidad
   if(posiciony>=200)
   posiciony=200;
    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento)))-vViento);
    posiciony=abs(floor(posiciony+v(j+1)*(cos(anguloLanzamiento))));

    if(posicionx>=200)
    posiciony=200;
    posicionx=abs(floor(posicionx+v(j+1)*cos(anguloLanzamiento)+vViento));
    posiciony=abs(floor(posiciony-v(j+1)*sin(anguloLanzamiento)));
    estaSubiendo=true;
  endif

  if(posicionx<1)
    posiciony=1;
    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento)))-vViento);
    posiciony=abs(floor(posiciony-v(j+1)*(cos(anguloLanzamiento))));
endif

  if(posiciony<1)
    posicionx=1;
    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento)))-vViento);
    posiciony=abs(floor(posiciony-v(j+1)*(cos(anguloLanzamiento))));

  endif
 endif
endif
 if(v<=0 & estaSubiendo)
 estaSubiendo=false;
endif

a(posiciony,posicionx)=255;
imshow(a);
pause(0.0001);
a(posiciony,posicionx)=0;
endfunction

for i=1:100
 %i es el espacio que recorro en el eje y
 for r=1:length(posiciones)
   particula(i,posiciones(r,1),posiciones(r,2))
   endfor
endfor

