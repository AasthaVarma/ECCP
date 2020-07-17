#include<bits/stdc++.h>
using namespace std;

int main()
{
	for(int i=1; i<=4; i++)
	{
		cout << "D"<<i<<": begin\n";
		cout << "     cword_alu      <= 10'h ;\n";
		cout << "     cword_reg_bank <= 23'h ;";
		cout <<"\n     " <<  "end\n";
	}
	for(int i=1; i<=8; i++)
	{
		cout << "A"<<i<<": begin\n";
		cout << "     cword_alu      <= 10'h ;\n";
		cout << "     cword_reg_bank <= 23'h ;";
		cout <<"\n     " <<  "end\n";
	}
	for(int i=1; i<=24; i++)
	{
		cout << "I"<<i<<": begin\n";
		cout << "     cword_alu      <= 10'h ;\n";
		cout << "     cword_reg_bank <= 23'h ;";
		cout <<"\n     " <<  "end\n";
	}
	return 0;
}
