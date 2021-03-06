%Ejercicio 11

Fm = 11025;
n1=load("nshima.txt");
N=length(n1);

subplot(2,2,1)
plot(n1);


df=Fm/N;
freq=-Fm/2:df:Fm/2-df;

fn1=fftp(n1);
Nfn1=length(fn1);

subplot(2,2,2)
plot(freq,fn1);

%Para encontrar la nota LA (440hz y armonicos) hago 0 todo lo que no sea la nota y hago la inversa

f1=fft(n1);%Tener en cuenta de que la fase es parte de f1
N1=length(f1);

%Hago tres simple y saco cual es 440 y sus multiplos en frecuencias
%69633 ---- 11025
%34816 -----5512 Seria mi 0 en frecuencia
% Entonces 440hz -->F positiva 2779 ---->F negativa N/2+2799= 8290
% Entonces 880hz -->F positiva 1389 ---->F negativa N/2+1389=6901 ---> Segundo Armonico Fundamental/2
% Entonces 1320hz -->F positiva 926 ---->F negativa N/2+926=6438 ---> Tercer Armonico Fundamental/3

%Pongo en 0 todas las frecuencias que no sean LA o armonicos de LA1
%Solo considere 2 armonicos de LA
%Igual tendrifftpa que usar un umbral de amplitud
umbral = 200;
f1=abs(f1);%Esto es para que no explote
for i = 1:N1
	if(i != 2778 && i != 8290 && i != 1389 && i != 6901 && f1(i) < umbral)
		f1(i) = 0;
	endif
endfor

%Grafico el filtrado
subplot(2,2,3)
plot(freq,f1);

n1la=real(ifft(f1));

subplot(2,2,4)
plot(n1la);
%Es muy malo el metodo, El ruido blanco tambien tiene la nota LA por lo tanto la reconoce tambien en el filtrado
%Pero la primera y la ultima nota que son las que importaba las dejo pasar
#wavwrite(n1la,11025,32,"Señal_Filtrada.wav");
#wavwrite(n1,11025,32,"Señal.wav");

%tengo que tener en cuenta la convolucion que hago aca con el filtro es una convolucion linal y no se corresponde con la covolucion en tiempo lineal. Por eso lo que tengo que hacer es zero-padding para poder aumentas a 2*N-1 de muestras y se corresponda la convolucion. Para hacerlo menos croto pordria hacer un metodo que tome una ventana que pueda capturar la nota la y sus armonicos y recorrer la señal en tiempo y ver si cada ventana tiene la nota la de manera de decir en que seccion de tiempo le corresponde.

