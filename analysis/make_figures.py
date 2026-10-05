"""Download, extract, validate, and plot budget authority (not outlays)."""
from pathlib import Path
import json
import os
from extract_data import extract
from download_sources import CACHE
os.environ.setdefault("MPLCONFIGDIR", str(CACHE / "matplotlib"))
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.ticker import PercentFormatter

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'figures'
OUT.mkdir(exist_ok=True)
tables = extract()
nsf = tables['nsf_budget'].set_index('fiscal_year')
nasa = tables['nasa_budget'].set_index('account')
hist = tables['nasa_history']
defl = tables['gdp_deflators'].set_index('fiscal_year')
RESULTS = CACHE / 'analysis'
RESULTS.mkdir(parents=True, exist_ok=True)
years = np.arange(2017,2027)
# Fail before plotting on coverage, duplication, inconsistent baselines or units.
assert nsf.index.is_unique and np.array_equal(nsf.index,years)
assert not hist.duplicated(['account','fiscal_year']).any()
assert defl.index.is_unique and (defl.gdp_price_index_fy2017_1>0).all()
for _,g in hist.groupby('account'):
    assert np.array_equal(g.fiscal_year,years)
    assert (g.budget_authority_musd>0).all()
assert nsf.loc[2023,'appropriation_musd']==9877
assert nsf.loc[2023,'baseline_musd']==8837
assert np.isclose(nsf.loc[2026, 'appropriation_musd'], 8750)
for col in ['fy2026_request_musd','fy2026_enacted_musd','fy2027_request_musd']:
    assert np.isclose(nasa.loc[nasa.level.eq('division'),col].sum(),nasa.loc['Science',col],atol=.25,rtol=0),col
for yr in [2025,2026]:
    for account in ['Science','Exploration']:
        assert hist.query('fiscal_year==@yr and account==@account').budget_authority_musd.item()==nasa.loc[account,f'fy{yr}_enacted_musd']

# Adam's ShearNet palette; line styles and markers redundantly encode identity.
navy,gold,gray='#003F5C','#C88700','#636363'
plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,'axes.labelsize':10,
 'axes.titlesize':10,'axes.spines.top':False,'axes.spines.right':False,
 'axes.linewidth':.7,'xtick.direction':'in','ytick.direction':'in',
 'legend.frameon':False,'legend.fontsize':9,'pdf.fonttype':42,'ps.fonttype':42,
 'savefig.dpi':240,'text.parse_math':False})

def save(fig,name):
    for ext in ['pdf','png']:
        fig.savefig(OUT/f'{name}.{ext}',bbox_inches='tight',facecolor='white')
    plt.close(fig)

def year_axis(ax):
    ax.set(xlim=(2016.65,2026.35),xlabel='Fiscal year')
    ax.set_xticks([2017,2020,2023,2026]);ax.set_xticks(years,minor=True)
    ax.grid(axis='y',color='.9',linewidth=.65);ax.set_axisbelow(True)

def real(values):
    """Align by fiscal year, never by row position. Constant FY2025 dollars."""
    d=defl.gdp_price_index_fy2017_1
    return values*d.loc[2025]/d.reindex(values.index)

def history_line(ax,values,color,marker,label,style='-'):
    ax.plot(values.index[:-1],values.iloc[:-1]/1000,color=color,marker=marker,
            ms=4,lw=1.7,ls=style,label=label)
    # Dotted link/open endpoint denote FY2026's estimated GDP deflator.
    ax.plot(values.index[-2:],values.iloc[-2:]/1000,color=color,lw=1.7,ls=':')
    ax.plot(values.index[-1],values.iloc[-1]/1000,color=color,marker=marker,
            mfc='white',ms=5,ls='none')

fig,(ax,bx)=plt.subplots(1,2,figsize=(8.2,3.35),layout='constrained')
for col,label,color,marker,ls in [
 ('appropriation_musd','Appropriated',navy,'o','-'),
 ('request_musd','Requested',gold,'^','--'),
 ('authorization_musd','Authorized',gray,'s',':')]:
    ax.plot(years,nsf[col]/1000,label=label,color=color,marker=marker,lw=1.7,ms=4,ls=ls)
ax.set(title='(a) NSF commitments',ylabel='Nominal $ billions',ylim=(0,20))
ax.set_yticks([0,5,10,15,20]);ax.legend(loc='upper left');year_axis(ax)
nsf_real=real(nsf.appropriation_musd)
history_line(bx,nsf_real,navy,'o','Appropriated')
adjusted=nsf.appropriation_musd-nsf.unavailable_emergency_musd
adjusted.loc[2023]=nsf.loc[2023,'baseline_musd']
adjusted_real=real(adjusted)
bx.scatter([2023,2025],adjusted_real.loc[[2023,2025]]/1000,marker='s',
           facecolor='white',edgecolor=gray,s=30,zorder=4)
bx.set(title='(b) NSF purchasing power',ylabel='FY2025 $ billions',ylim=(0,12))
bx.set_yticks([0,3,6,9,12]);year_axis(bx)
save(fig,'funding_gap')

fig,(ax,bx)=plt.subplots(1,2,figsize=(8.8,3.7),layout='constrained',gridspec_kw={'width_ratios':[1,1.15]})
for account,color,marker,ls in [('Science',navy,'o','-'),('Exploration',gold,'s','--')]:
    v=hist.query('account==@account').set_index('fiscal_year').budget_authority_musd
    history_line(ax,real(v),color,marker,account,ls)
ax.set(title='(a) NASA funding',ylabel='FY2025 $ billions',ylim=(0,10))
ax.set_yticks([0,2,4,6,8,10]);ax.legend(loc='lower right');year_axis(ax)
order=['Exploration','NASA total','Science','Planetary science','Earth science','Heliophysics','Astrophysics','Biological and physical sciences']
a=nasa.loc[order].copy();a['change_pct']=100*(a.fy2027_request_musd/a.fy2026_enacted_musd-1)
y=np.arange(len(a))[::-1]
bx.hlines(y,0,a.change_pct,color=navy,lw=1.6);bx.scatter(a.change_pct,y,color=navy,s=27,zorder=3)
bx.axvline(0,color=gray,lw=.8);bx.axhline(4.5,color='.8',lw=.6)
bx.set(yticks=y,yticklabels=['Exploration','NASA total','Science total','Planetary','Earth','Heliophysics','Astrophysics','Bio./physical'],
       xlim=(-82,19),ylim=(-.6,7.6),xlabel='Change from FY2026',title='(b) FY2027 request')
bx.set_xticks([-80,-60,-40,-20,0]);bx.xaxis.set_major_formatter(PercentFormatter())
bx.grid(axis='x',color='.9',lw=.65);bx.set_axisbelow(True)
save(fig,'nasa_priorities')

history=pd.concat([nsf.appropriation_musd.rename('budget_authority_musd').reset_index().assign(account='NSF'),
 hist[['fiscal_year','account','budget_authority_musd']]],ignore_index=True).merge(defl.reset_index(),on='fiscal_year',validate='many_to_one')
history['constant_fy2025_musd']=history.budget_authority_musd*defl.loc[2025,'gdp_price_index_fy2017_1']/history.gdp_price_index_fy2017_1
history['real_index_fy2017_100']=history.groupby('account').constant_fy2025_musd.transform(lambda v:100*v/v.iloc[0])
history.to_csv(RESULTS/'ten_year_budget.csv',index=False,float_format='%.6f')
comparison={}
for account,g in history.groupby('account'):
    g=g.set_index('fiscal_year')
    comparison[account]={
      'nominal_change_2017_2026_pct':100*(g.loc[2026,'budget_authority_musd']/g.loc[2017,'budget_authority_musd']-1),
      'real_change_2017_2025_pct':100*(g.loc[2025,'constant_fy2025_musd']/g.loc[2017,'constant_fy2025_musd']-1),
      'real_change_2017_2026_pct_estimated_deflator':100*(g.loc[2026,'constant_fy2025_musd']/g.loc[2017,'constant_fy2025_musd']-1)}
nsf25 = nsf.loc[2025, 'appropriation_musd']
nsf26 = nsf.loc[2026, 'appropriation_musd']
request26 = nsf.loc[2026, 'request_musd']
authorization26 = nsf.loc[2026, 'authorization_musd']
science = nasa.loc['Science']
metrics={
 'nsf_fy26_authorization_share_pct':100*nsf26/authorization26,
 'nsf_fy26_authorization_gap_musd':authorization26-nsf26,
 'nsf_fy26_change_vs_enacted_pct':100*(nsf26/nsf25-1),
 'nsf_fy26_change_vs_adjusted_pct':100*(nsf26/adjusted.loc[2025]-1),
 'nsf_fy26_proposed_reduction_offset_pct':100*(nsf26-request26)/(nsf25-request26),
 'nasa_science_fy26_proposed_reduction_offset_pct':100*(science.fy2026_enacted_musd-science.fy2026_request_musd)/(science.fy2025_enacted_musd-science.fy2026_request_musd),
 'nasa_fy27_change_pct':a.change_pct.to_dict(),
 'ten_year_comparison':comparison,
 'nsf_real_change_2020_2026_pct_estimated_deflator':100*(nsf_real.loc[2026]/nsf_real.loc[2020]-1),
 'nsf_real_change_2017_2025_adjusted_pct':100*(adjusted_real.loc[2025]/nsf_real.loc[2017]-1),
 'note':'Real values use OMB FY2027 GDP price indices, not research-specific costs; FY2026 index is estimated. Ten observations span nine annual changes.'}
(RESULTS/'derived_metrics.json').write_text(json.dumps(metrics,indent=2)+'\n')
a.to_csv(RESULTS/'nasa_changes.csv')
print(json.dumps(metrics,indent=2))
