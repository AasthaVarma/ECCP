#include<bits/stdc++.h>
using namespace std;

void logic(int n)
{
	int i=0, j=1, k=0;
	cout << "assign c["<<k<<"] = d0;\n";
	k++;
	while(i<j)
	{
		cout <<"assign c["<<k<<"] = d"<<i << "_"<<j;
		if(i<j)
		{
			int r = i, s = j; 
			
			while(r<s-1)
			{
				if(r+2 != s)
				{
					cout << " ^ d" << r+1 << "_"<< s-1;
					cout  << " ^ d" << r+1 << " ^ d" << s-1; 
				}
				else
					cout << " ^ d" << r+1;
				r++;s--;
			}	
			cout << " ^ d" << i << " ^ d" << j ;
		}
		cout << ";\n";
		if(j!=n-1)
			j++;
		else
			i++;
		k++;
	}
	cout << "assign c["<<k<<"] = d"<<n-1<<";\n";
}
int main()
{
	int n=14;
	cout << "wire d" << 0;
	for(int i=1; i<n; i++)
	{
		cout << ",d" << i;
	}
	cout << ";\n\n";
	
	for(int i=0; i<n-1; i++)
	{
		int j=i+1;
		cout << "wire d" << i << "_" << j;
		j++;
		for(; j<n; j++)
			cout << ",d" << i << "_" << j;
		cout << ";\n";
	}
	cout << "\n";
	
	//logic----- d[i] = a[i] & b[i];
	for(int i=0; i<n; i++)
		cout << "assign d" << i << " = a[" << i <<"] & b["<<i<<"];\n";
	
	cout << "\n\n";
	//logic------d[i][j] = (a[i]^a[j]) & (b[i]^b[j]);
	for(int i=0; i<n-1; i++)
	{
		for(int j=i+1; j<n; j++)
		{
			cout << "assign d"<<i<<"_"<<j<<" = " << 
			"(a["<<i<<"]^a["<<j<<"])&(b["<<i<<"]^b["<<j<<"]);\n";
		}
	}
	cout << "\n\n";
	logic(n);
	return 0;
}
