import java.util.Scanner;

public class Conv {
	public static void main(String[] args) {
		//init
		double x = 0;
		double y = 0;
		double z = 0;
		char str= ' ';
		Scanner sc= new Scanner(System.in);
				
		do	{
			do	{
				System.out.println("Veuillez entrer la tempŽrature de dŽbut:");
				x= sc.nextDouble();
				System.out.println("Maintenant, Veuillez entrer la tempŽrature de fin:");
				y= sc.nextDouble();
				System.out.println("Pour finir, veuillez entrer le pas entre chaques valeurs affichŽes au tableau:");
				z= sc.nextDouble();
				
				while (str !='Y')	{
					System.out.println("Let's Go ?! (Y)");
					str= sc.next().charAt(0);
				}
				
				if (x > y || z > y )
					System.out.println("Veuillez recommencer, une erreur s'est produite!");
					str =' ';
				}	 while (x > y || z > y || y < x);
			 System.out.println("Celsius	|	Fahrenheint");
				
				while (x<y+1)	{
					double toFar = 9 / 5 * x + 32;
					System.out.println(x+"¡C	|	"+ toFar +"¡F");
					x+=z;
				}
				
				while (str!='O' && str!='N')	{
					System.out.println("Voulez vous entrer d'autres valeurs ? (O/N)");
					str= sc.next().charAt(0);
				}
		}	while ( str != 'N');
		
		System.out.println("Au revoir!");
		//End
	}
}
