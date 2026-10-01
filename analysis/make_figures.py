"""Reproduce the paper's descriptive budget comparisons
Run: python analysis/make_figures.py
Inputs are transcribed nominal budget authority, millions of US dollars
"""
from pathlib import Path
import json
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.ticker import PercentFormatter

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'figures'
OUT.mkdir(exist_ok=True)
nsf = pd.read_csv(ROOT / 'data/nsf_budget.csv')
nasa = pd.read_csv(ROOT / 'data/nasa_budget.csv').set_index('account')
# Catch unit/transcription errors that would invalidate the comparisons.
divs = nasa[nasa.level.eq('division')]
for column in ['fy2026_request_musd', 'fy2026_enacted_musd', 'fy2027_request_musd']:
 assert np.isclose(divs[column].sum(), nasa.loc['Science', column], atol=0.25, rtol=0), column
assert np.isclose(7176.5+251+938.25+355+5.09+24.16, 8750)
assert not nsf.fiscal_year.duplicated().any()

plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,'axes.labelsize':10,
 'axes.titlesize':11,'axes.spines.top':False,'axes.spines.right':False,
 'pdf.fonttype':42,'ps.fonttype':42,'savefig.dpi':220,'text.parse_math':False})
blue,orange,gray,purple='#0072B2','#D55E00','#555555','#6B4C9A'

def save(fig,name):
 for ext in ['pdf','png']:fig.savefig(OUT / f'{name}.{ext}',bbox_inches='tight',facecolor='white')
 plt.close(fig)

# Figure 1: policy commitments and enacted budgets, not estimates of research output.
fig,axs=plt.subplots(1,2,figsize=(8.0,3.5),gridspec_kw={'width_ratios':[1.3,1]})
ax=axs[0]
x=nsf.fiscal_year.to_numpy()
for col,label,color,marker,style in [
 ('authorization_musd','Authorized',gray,'s','--'),
 ('appropriation_musd','Appropriated',blue,'o','-'),
 ('request_musd','President\'s request',orange,'^',':')]:
 ax.plot(x,nsf[col]/1000,label=label,color=color,marker=marker,linestyle=style,lw=1.8,ms=6)
 ax.annotate(f'{nsf[col].iloc[-1]/1000:.2f}',(2026,nsf[col].iloc[-1]/1000),xytext=(5,0),textcoords='offset points',color=color,va='center',fontsize=9)
ax.scatter([2025],[8.826],facecolor='white',edgecolor=blue,zorder=5,s=45)
ax.set(title='A  NSF funding commitments',ylabel='Nominal budget authority ($ billions)',xlabel='Fiscal year',xlim=(2022.8,2026.65),ylim=(0,21))
ax.set_xticks(x);ax.set_yticks([0,5,10,15,20]);ax.grid(axis='y',alpha=.18)
ax.legend(loc='lower left',ncol=1,fontsize=9,frameon=False)
ax.text(.02,-.27,'FY2023 includes supplemental funding.\nOpen circle: adjusted FY2025 funding.',transform=ax.transAxes,fontsize=8.5,va='top')
ax=axs[1]
# Both FY2026 outcomes use FY2025 enacted as the same denominator.
base=np.array([9060,nasa.loc['Science','fy2025_enacted_musd']])
request=np.array([3903.2,nasa.loc['Science','fy2026_request_musd']])
enacted=np.array([8750,nasa.loc['Science','fy2026_enacted_musd']])
rq=100*(request/base-1);en=100*(enacted/base-1)
y=np.array([1,0])
ax.hlines(y,rq,en,color='#b4b4b4',lw=2,zorder=1)
ax.scatter(rq,y,color=orange,marker='^',s=55,label='FY2026 request',zorder=3)
ax.scatter(en,y,color=blue,marker='o',s=55,label='FY2026 enacted',zorder=3)
for i in range(2):
 ax.annotate(f'{rq[i]:.1f}%',(rq[i],y[i]),xytext=(0,10),textcoords='offset points',ha='center',color=orange,fontsize=9)
 ax.annotate(f'{en[i]:.1f}%',(en[i],y[i]),xytext=(-1,10),textcoords='offset points',ha='center',color=blue,fontsize=9)
ax.axvline(0,color='black',lw=.8)
ax.set(yticks=y,yticklabels=['NSF','NASA\nScience'],xlim=(-66,7),ylim=(-.55,1.65),title='B  FY2026 budget outcome',xlabel='Change from FY2025 enacted')
ax.xaxis.set_major_formatter(PercentFormatter());ax.grid(axis='x',alpha=.18)
ax.legend(loc='lower left',fontsize=8.5,frameon=False)
ax.text(.02,-.27,'Adjusted NSF baseline: −0.9% change\n(see text for the $234M adjustment).',transform=ax.transAxes,fontsize=8.5,va='top')
fig.subplots_adjust(wspace=.44,bottom=.25,top=.89)
save(fig,'funding_gap')

# Figure 2: keep subaccounts distinct; rows cannot be summed.
order=['Exploration','NASA total','Science','Planetary science','Earth science','Heliophysics','Astrophysics','Biological and physical sciences']
a=nasa.loc[order].copy()
a['change_pct']=100*(a.fy2027_request_musd/a.fy2026_enacted_musd-1)
fig,ax=plt.subplots(figsize=(8.0,3.65))
y=np.arange(len(a))[::-1]
colors=[blue if v>=0 else orange for v in a.change_pct]
ax.hlines(y,0,a.change_pct,color=colors,lw=2)
ax.scatter(a.change_pct,y,c=colors,s=45,zorder=3)
labels=['Exploration','NASA total','Science total','  Planetary science','  Earth science','  Heliophysics','  Astrophysics','  Biological / physical']
ax.set(yticks=y,yticklabels=labels,xlim=(-91,47),ylim=(-.6,8.2),xlabel='Proposed FY2027 change from FY2026 funding')
ax.xaxis.set_major_formatter(PercentFormatter());ax.set_xticks([-80,-60,-40,-20,0,20])
ax.axvline(0,color='black',lw=.8);ax.grid(axis='x',alpha=.15)
for yi,(_,row),color in zip(y,a.iterrows(),colors):
 v=row.change_pct
 ax.annotate(f'{v:+.1f}%',(v,yi),xytext=(-7,0) if v<0 else (0,10),textcoords='offset points',ha='right' if v<0 else 'center',va='center',color=color,fontsize=9)
 ax.text(46,yi,f'{row.fy2026_enacted_musd/1000:.3f} → {row.fy2027_request_musd/1000:.3f}',ha='right',va='center',fontsize=9,bbox={'facecolor':'white','edgecolor':'none','pad':1})
ax.text(46,7.85,'FY26 → FY27 ($B)',ha='right',fontsize=9,fontweight='bold')
ax.axhline(4.5,color='#cccccc',lw=.6)
fig.subplots_adjust(left=.25,right=.98,bottom=.17,top=.94)
save(fig,'nasa_priorities')

metrics={
 'nsf_fy26_authorization_share_pct':100*8750/17832,
 'nsf_fy26_authorization_gap_musd':17832-8750,
 'nsf_fy26_change_vs_enacted_pct':100*(8750/9060-1),
 'nsf_fy26_change_vs_adjusted_pct':100*(8750/8826-1),
 'nsf_fy26_proposed_reduction_offset_pct':100*(8750-3903.2)/(9060-3903.2),
 'nasa_science_fy26_proposed_reduction_offset_pct':100*(7250-3907.6)/(7334.2-3907.6),
 'nasa_fy27_change_pct':a.change_pct.to_dict(),
 'house_fy27_nsf_change_pct':100*(7000/8750-1),
 'house_fy27_science_change_pct':100*(6000/7250-1)}
(ROOT/'analysis/derived_metrics.json').write_text(json.dumps(metrics,indent=2)+'\n')
a.to_csv(ROOT/'analysis/nasa_changes.csv')
print(json.dumps(metrics,indent=2))
