#include<bits/stdc++.h>
#define m 233
#define n 74
using namespace std;

// reminder -- just the naive implementation
// can be optimized to a great scale
int main()
{
	int size = 2*m-1;
	vector<int> a[size];
	for(int i=0; i<size; i++)
	{
		a[i].push_back(i);
	}
	int n_pow, con_pow;
	n_pow = n; con_pow = 0;
	for(int i=m; i<size-1; i++)
	{
		if(n_pow >= m)
		{
			a[n_pow-m+n].push_back(i);
			a[n_pow-m].push_back(i);
			
		}
		else
			a[n_pow].push_back(i);
		a[con_pow].push_back(i);
		n_pow++;
		con_pow++;
	}
	//cout << n_pow << ", " << con_pow << "\n";
	int k = size-1;
	if(n_pow >= m)
	{
		a[n_pow-m+n].push_back(k);
		a[n_pow-m].push_back(k);
		
	}
	else
		a[n_pow].push_back(k);
	a[con_pow].push_back(k);
	for(int i=0; i<m; i++)
	{
		int j=0;
		cout << "assign d["<<i<<"] = a[" << a[i][j] << "]";
		j++;
		for(; j<a[i].size(); j++)
		   cout	<< " ^ a["<<a[i][j] << "]";
		cout << ";\n";
	}
	return 0;
}
