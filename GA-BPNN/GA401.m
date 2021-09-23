clc;
clear all;
close all;
global BitLength
global boundsbegin
global boundsend
bounds=[-2 2];
precision=0.0001; 
boundsbegin=bounds(:,1);
boundsend=bounds(:,2);
BitLength=ceil(log2((boundsend-boundsbegin)' ./ precision));
popsize=50; 
Generationnmax=12;  
pcrossover=0.90; 
pmutation=0.09; 
population=round(rand(popsize,BitLength));
[Fitvalue,cumsump]=fitnessfun(population);  
Generation=1;
while Generation<Generationnmax+1
   for j=1:2:popsize 
      seln=selection(population,cumsump);
      scro=crossover(population,seln,pcrossover);
      scnew(j,:)=scro(1,:);
      scnew(j+1,:)=scro(2,:);
      smnew(j,:)=mutation(scnew(j,:),pmutation);
      smnew(j+1,:)=mutation(scnew(j+1,:),pmutation);
   end
   population=smnew;   
   [Fitvalue,cumsump]=fitnessfun(population);
   [fmax,nmax]=max(Fitvalue);
   fmean=mean(Fitvalue);
   ymax(Generation)=fmax;
   ymean(Generation)=fmean;
   x=transform2to10(population(nmax,:));
  xx=boundsbegin+x*(boundsend-boundsbegin)/(power((boundsend),BitLength)-1);
   xmax(Generation)=xx;
   Generation=Generation+1;
end
Generation=Generation-1;
Bestpopulation=xx;
Besttargetfunvalue=targetfun(xx);
figure(1);
hand1=plot(1:Generation,ymax);
set(hand1,'linestyle','-','linewidth',1.8,'marker','*','markersize',6)
hold on;
hand2=plot(1:Generation,ymean);
set(hand2,'color','r','linestyle','-','linewidth',1.8,...
'marker','h','markersize',6)
xlabel('Evolutionary algebra');ylabel('Maximum / average fitness');xlim([1 Generationnmax]);
legend('Maximum fitness ',' Average fitness');
box off;hold off;
disp(['Optimal x value:' num2str(Bestpopulation)]);
disp(['Function maximum:' num2str(Besttargetfunvalue)]);