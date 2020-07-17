#include<bits/stdc++.h>
#define n 233
//for n=233, 117, 116, 59, 58, 30, 29
//for n=14 and 15 general karatsuba algorithm
using namespace std;

// naive implementation -- can be optimized
int main()
{
	int ab_h[n-2], ab_l[n], ab_hl[n], d[2*n-1];
	
	
	if(n%2!=0){
	cout << "// n = " << n/2+1 <<"(higher) + "<<n/2<<"(lower)" << "\n";
	cout << "wire [" << n-1 <<":0]ab_l; //(al * bl) //" << n-1 << "\n";
	cout << "wire [" << n-3 <<":0]ab_h; //(ah * bh) //" << n-1 << "\n";
	cout << "wire [" << n-1 <<":0]ab_hl; //(al * bl) * al * bl //n=" << n  << "bits\n";
	cout << "wire [" << n/2 <<":0] a_hl; // (ah + al)\n";
	cout << "wire [" << n/2 <<":0] b_hl; // (bh + bl)\n\n";
	}
	else
	{
	cout << "// n = " << n/2 <<"(higher) + "<<n/2<<"(lower)" << "\n";
	cout << "wire [" << n-2 << ":0]ab_l; //(al * bl) //" << n-1 << "\n";
	cout << "wire [" << n-2 << ":0]ab_h; //(ah * bh) //" << n-1 << "\n";
	cout << "wire [" << n-2 << ":0]ab_hl; //(al * bl) * al * bl //n = "<< n  << "bits\n";
	cout << "wire [" << n/2-1 <<":0] a_hl; // (ah + al)\n";
	cout << "wire [" << n/2-1 <<":0] b_hl; // (bh + bl)\n\n";
	}
	
	
	
	cout << "//just to remind myself: addition is **xor** not *and*\n// al = a[floor(n/2):0] ; ah = a[n:ceil(n/2)]; same goes for b\n\n";
	if(n%2==0){
	cout << "assign a_hl["<<n/2-1<<":0]      = a[" << n-1 << ":" << n/2 <<"] ^ a["<<n/2-1 <<":" << 0 <<"]; // (ah + al)\n";
	cout << "assign b_hl["<<n/2-1<<":0]      = b[" << n-1 << ":" << n/2 <<"] ^ b["<<n/2-1 <<":" << 0 <<"]; // (bh + bl)\n\n";
	cout << "\n\n";
	cout << "krtsba_"<<n/2<<" k1(ab_h, a[" <<n-1<<":"<<n/2<<"],b["<<n-1<<":"<<n/2<<"]);\n";
	cout << "krtsba_"<<n/2<<" k2(ab_l, a["<<n/2-1<<":"<<0<<"],b["<<n/2-1<<":0]);\n";
	cout << "krtsba_"<<n/2<<" k3(ab_hl, a_hl, b_hl);\n\n";
	
	}
	else
	{
	cout << "assign a_hl["<<n/2-1<<":0]"<<"      = a["<<n-1<<":"<<n/2+1<<"] ^ a["<<n/2-1<<":0];  // (ah + al)\n";
	cout << "assign a_hl["<<n/2<<"] = a["<<n/2<<"] ; //did this because two operands are "<<n/2 <<" and "<<n/2+1<<" bits respectively\n";
	cout << "assign b_hl["<<n/2-1<<":0]"<<"      = b["<<n-1<<":"<<n/2+1<<"] ^ b["<<n/2-1<< ":0];  // (bh + bl)\n";
	cout << "assign b_hl["<<n/2<<"] = b["<<n/2<<"];  //did this because two operands are "<<n/2 <<" and "<<n/2+1<<" bits respectively\n";
	cout << "\n\n";
	cout << "krtsba_"<<n/2<<" k1(ab_h, a["<<n-1<<":"<<n/2+1<<"] , b["<<n-1<<":"<<n/2+1<<"] ); \n";
	cout << "krtsba_"<<n/2+1<<" k2(ab_l, a["<<n/2<<":"<<0<<"] , b["<<n/2<<":"<<0<<"] ); \n";
	cout << "krtsba_"<<n/2+1<<" k3(ab_hl, a_hl, b_hl);\n\n";
	
	}
	
	
		
	if(n%2!=0)
	{
		for(int i=0; i<2*n-1; i++)
		{
			if(0<=i && i<=n/2)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i << "]" << ";\n";
			}
			else if ((n/2)+1<=i && i<=n-1)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i << "]^" << "ab_l[" << i-((n/2)+1) << "]^" 
				<< "ab_h[" << i-((n/2)+1) << "]^" << "ab_hl[" << i-((n/2)+1)<< "]" << ";\n";
			}
			else if(i==n)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i-((n/2)+1) << "]^" 
				<< "ab_h[" << i-((n/2)+1) << "]^" << "ab_hl[" << i-((n/2)+1) << "]" << ";\n";
			}
			else if(n+1<=i && i<=(3*n)/2-2)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i-((n/2)+1) << "]^" << "ab_h[" << i-((n/2)+1) << "]^"
				 << "ab_hl[" << i-((n/2)+1) << "]^" << "ab_h[" << i-(n+1) << "]"<< ";\n";
			}
			else if((3*n)/2-1<=i && i<=(3*n)/2)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i-((n/2)+1) << "]^" 
				<< "ab_hl[" << i-((n/2)+1)<< "]^" << "ab_h[" << i-(n+1) << "]" << ";\n";
			}
			else 
			{
				cout << "assign d[" << i << "]" << " = " << "ab_h[" << i-(n+1) << "]" << ";\n";
			}
		}
	}
	else 
	{
		for(int i=0; i<2*n-1; i++)
		{
			if(0<=i && i<n/2)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i << "]" << ";\n";
			}
			else if ((n/2)<=i && i<n-1)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i << "]^" << "ab_l[" << i-((n/2)) << "]^" 
				<< "ab_h[" << i-((n/2)) << "]^" << "ab_hl[" << i-((n/2))<< "]" << ";\n";
			}
			else if(i==n-1)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i-((n/2)) << "]^" 
				<< "ab_h[" << i-((n/2)) << "]^" << "ab_hl[" << i-((n/2)) << "]" << ";\n";
			}
			else if(n<=i && i<=(3*n)/2-2)
			{
				cout << "assign d[" << i << "]" << " = " << "ab_l[" << i-((n/2)) << "]^" << "ab_h[" << i-((n/2)) << "]^"
				 << "ab_hl[" << i-((n/2)) << "]^" << "ab_h[" << i-(n) << "]"<< ";\n";
			}
			else 
			{
				cout << "assign d[" << i << "]" << " = " << "ab_h[" << i-(n) << "]" << ";\n";
			}
		}
	}
	
	return 0;
}
