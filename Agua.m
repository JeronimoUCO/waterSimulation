clear all

close all

a=zeros(200,200);

imshow(a)

function crearParticula(ang, vV,gravedad, friccion, x,y, iterator)
anguloLanzamiento=ang ;
v(1)=0;
vViento=vV;
g=gravedad;
b=friccion;
estaSubiendo=false;
posicionx=x;
posiciony=y;

j=iterator;
 %i es el espacio que recorro en el eje y
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
    posicionx=abs(floor(posicionx-v(j+1)*(cos(anguloLanzamiento))));
    posiciony=abs(floor(posiciony+v(j+1)*(sin(anguloLanzamiento)))-vViento);

    if(posicionx>=200)
    posiciony=200;
    posicionx=abs(floor(posicionx+v(j+1)*(cos(anguloLanzamiento))));
    posiciony=abs(floor(posiciony-v(j+1)*(sin(anguloLanzamiento)))-vViento);
    estaSubiendo=true;
  endif

  if(posicionx<=1)
    posiciony=1;
    posicionx=abs(floor(posicionx+v(j+1)*(cos(anguloLanzamiento))));
    posiciony=abs(floor(posiciony-v(j+1)*(sin(anguloLanzamiento)))-vViento);
endif

  if(posiciony<=1)
    posicionx=1;
    posicionx=abs(floor(posicionx-v(j+1)*(sin(anguloLanzamiento))));
    posiciony=abs(floor(posiciony+v(j+1)*(cos(anguloLanzamiento)))-vViento);

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
j=iterator;
endfunction

for i=1:100
crearParticula(20/180,5,9.8,0.005,25,25,i);
endfor


