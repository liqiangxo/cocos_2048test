#include <stdio.h>
#include <setjmp.h>
#include <time.h>
static jmp_buf buf;

void second(){
	printf("second\n");
	longjmp(buf,1);
}

void first(){
	second();
	printf("first\n");
}
int main(int argc,char * argv[])
{
	printf("hello, World!");
	//关键字
	//auto else long switch break enum register typedef
	//case extern return union char float short unsigned
	//const for signed void continue goto sizeof volatile 
	//default if static while do int struct _Packed double
	union{
		int i;
		char a[2];
	}*p,u;
	p = &u;
	p->a[0] = 97;
	p->a[1] = 98;
	printf("%d",p->i);	
	
	
	if(!setjmp(buf)){
		first();
	}else{
		printf("main\n");		
	}

	for(int i=0;i<1000000;i++){}
	//int k=5,n=0;
	//do
	//{
	//	switch(k)
	//	{
	//		case1: 
	//		case3:n+=1; break;
	//		default:n=0;k--;
	//		case2: 
	//		case4:n+=2;k--;break;
	//}
	
	//printf("%d\n",n);
	//}while(k>0&&n<5);

	//daoxu(char *str){
	//	char * s;
	//}
int a[4][4]={{1,4,3,2,},{8,6,5,7,},{3,7,2,5,},{4,8,6,1,}},i,j,k,t;
for(i=0;i<4;i++)
for(j=0;j<3;j++)
for(k=j+1;k<4;k++)
if(a[j][i]>a[k][i]){t=a[j][i];a[j][i]=a[k][i];a[k][i]=t;}/*按列排序*/
for(i=0;i<4;i++)printf("%d,",a[i][j]);
	char * num = "str";
	
	//printf("a[1][0]: %d\n",a[1][0]);	

	clock_t end_t = clock();
	printf("CPU 占用总时间：%.2lu",end_t);
	return 0;
}
