#!usr/bin/env/bash

sed 's/CNC(=O)C/CNC(=O)CCC1(C)N=N1/' Dansyl_CACCA.smi > Dansyl_Diazirine_CACCA.smi
#make acetamide to alkyl diazirine


sed 's/CNC(=O)C/CNC(=O)CCC1CO1/' Dansyl_CACCA.smi > Dansyl_Epoxide_CACCA.smi


sed 's/CNC(=O)C/CNC(=O)C1=CC=CC(=C1)C(=O)C1=CC=CC=C1/' Dansyl_CACCA.smi > Dansyl_Benzophenone_CACCA.smi


echo "sed plays with smiles"
echo "NC(=O)C1=CC=CC(=C1)C(=O)C1=CC=CC=C1"
echo "Done"
