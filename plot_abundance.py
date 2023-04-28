import seaborn as sns, numpy as np, pandas as pd
from numpy import inf

data=pd.read_csv('assemble/contig_counts.tsv',sep='\t')
data=data.drop(columns='length').melt(['contig']).replace({'-DNA.idxstats.txt':' '}, regex=True)

plt.figure(figsize=(8,12))
data['log_value']=np.log10(data.value)
data['log_value'][np.isneginf(data['log_value'])] = 0
data['log_abundance']=data['log_value'].fillna(0)
tmp=sns.violinplot(data=data, y="variable", x="log_abundance",scale="count")