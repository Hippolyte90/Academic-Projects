#include<stdio.h>
#include<stdlib.h>
#include<time.h>
int main (void)
{
	int n,x,e,a,y;
    int MAX,MIN;
       srand(time(NULL));
   
       printf(" entrer le nombre 1 si vous souhaitez jouer au jeu ou 0 si vous ne voulez pas,puis appuis sur la touche ENTRER\n"); 
     scanf("%d",&a);
    while(a!=0)
   {  
       printf("etats de dificultees\n");
       printf("1= de 1 a 100\n");
       printf("2= de 2 a 200\n");
       printf("3=de 3 a 300\n");
       printf("choisir un etat de difficultee\n");
       scanf("%d",&x);
       switch(x)
       {
       	case 1:
			MAX=100;
			MIN=1;
		 printf("choixir un nombre COMPRIS entre 1 et 100 pour voir si c'est un nombre Mysterieur,puis appuis sur la touche ENTRER\n");break;
		case 2:
			MAX=200;
			MIN=2;
       	 printf("choixir un nombre COMPRIS entre 2 et 200 pour voir si c'est un nombre Mysterieur,puis appuis sur la touche ENTRER\n");break;
		case 3:
		    MAX=300;
			MIN=3;
       	 printf("choixir un nombre COMPRIS entre 3 et 300 pour voir si c'est un nombre Mysterieur,puis appuis sur la touche ENTRER\n");break;
		default : ;	
	   }
	   scanf("%d",&x);
	    n=(rand()%(MAX-MIN+1))+MIN;
       e=1;
      while(x!=n)
     {
    	if(x<n)
    	printf("c'est moin\n");
    	else
   	  printf("c'est plus\n");
      printf(" C'est ne pas ca,Quel est le nombre ?\n");
        scanf("%d",&x);
         e++;
    }
       printf("BRAVOO ,vous avez trouvee le nombre mysterieur en %d coups\n",e);
       printf("voulez vous continuer le test ?\n");
	 printf("alors,si oui, entrer le nombre 1 dans le car contraire entrer 0 pour sortir \n"); 
     scanf("%d",&a);
  }
  printf("aurevoie monsieur ,merci pour l'essaie,appuis sur la touche ENTRER pour fermer la fenetre\n");     
  
   return 0 ;
}
