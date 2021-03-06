%CHOOSGM  calls up a window for estimation of optimal bandwidth for
%         Gasser - Mueller estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if ~exist('Inmat','var')
   Inmat=zeros(12,4);Inp=Inmat;
else
   Inmat(:,3)=0;Inp=Inmat;
end;
bcgcol=[.8529 .8529 .8529];
tw=0.08;
editFig=findobj(0,'name','EDIT');
hndlList=get(editFig,'UserData');   
hHndl=hndlList(4);
gmstr='Choosing the optimal bandwidth for the Gasser - Mueller estimator';
callstr=['sez=findobj(gcf,''style'',''radiobutton'');set(sez,''Value'',0);set(gco,''Value'',1);',...
    'tg=get(gco,''Tag'');vedle=findobj(gcf,''Tag'',tg(1:end-3));actual=get(vedle,''string'');hpom=actual(2,5:end);',...
    'set(acth,''String'',hpom);set(hHndl,''String'',hpom);h=str2num(hpom);save v.mat h -append;'];

uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'Position',[0.15,hor-.15,.7,.13], ...
        'ForegroundColor','blue', ...
        'BackgroundColor',[.7 .7 .7], ...
        'FontSize',13,...
        'FontUnits','normalized',...
        'String',gmstr);
     
 uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'Position',[vert-.01,hor-16*vys-.03,.55,.67], ...
        'BackgroundColor',bcgcol);
     
 uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'Position',[vert,hor-4*vys-.02,.53,.05], ...
        'BackgroundColor',bcgcol,...
        'FontUnits','normalized',...
        'FontSize',12,...
        'String','Penalizing functions');
%        'ForegroundColor',[0.6 .9 0.9], ...
     
%generalized cross-validation    
 uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.27,hor-12*vys-.05,.13,.05], ...
         'BackgroundColor',[.5,0.5,0.5], ...
         'Callback',['set(gmgcv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhg3,gcv3,gtr3]=gcvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmgcv,''String'',CH);Inmat(1,3)=1;Inp(1,3)=1;',...
         'set(gmgcvz,''Enable'',''on'');set(gmgcvset,''Visible'',''on'');'],...   
         'String','Generaliz. CV');
         
gmgcv=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135+.27,hor-13*vys-.05,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmgcv',...
   'String','');
            
gmgcvz=uicontrol('Style','push','Units','normalized', ...
   'FontUnits','normalized',...
          'Position',[vert+.27,hor-13*vys-.05,.13,.05], ...
          'Callback',['figure;plot(hhg3,gcv3,''r'');',...
          'title(''GCV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');      
      
gmgcvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215+.27,hor-13*vys-.05,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmgcvset',...
   'String','');      
       
%Classic cross-validation       
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert,hor-6*vys-.02,.13,.05], ...
         'Callback',['set(gmcv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhcv3,cv3]=cvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmcv,''String'',CH);Inmat(11,3)=1;Inp(11,3)=1;',...
         'set(gmcvz,''Enable'',''on'');set(gmcvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'ForegroundColor',[.6,0.2,0.2], ...
         'String','Classic CV');
         
gmcv=uicontrol( ...
	'Style','text', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135,hor-7*vys-.02,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmcv',...
   'String','');
            
gmcvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert,hor-7*vys-.02,.13,.05], ...
          'Callback',['figure;plot(hhcv3,cv3,''r'');',...
          'title(''Classic CV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'ForegroundColor',[.6,0.2,0.2], ...
          'String','draw',...
          'Enable','off');       
       
gmcvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215,hor-7*vys-.02,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmcvset',...
   'String','');
       
%Akaike       
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.27,hor-8*vys-.03,.13,.05], ...
         'Callback',['set(gmacv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hha3,acv3,atr3]=acvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmacv,''String'',CH);Inmat(2,3)=1;Inp(2,3)=1;',...
         'set(gmacvz,''Enable'',''on'');set(gmacvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Akaike CV');
         
gmacv=uicontrol( ...
	'Style','text', ...
   'BackgroundColor',bcgcol,...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'Position',[vert+.135+.27,hor-9*vys-.03,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmacv',...
   'String','');
            
gmacvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert+.27,hor-9*vys-.03,.13,.05], ...
          'Callback',['figure;plot(hha3,acv3,''r'');',...
          'title(''Akaike CV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
      
gmacvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215+.27,hor-9*vys-.03,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmacvset',...
   'String','');
      
%Finite prediciton       
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.27,hor-6*vys-.02,.13,.05], ...
         'Callback',['set(gmfpecv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhfp3,fpcv3,fptr3]=fpecvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmfpecv,''String'',CH);Inmat(3,3)=1;Inp(3,3)=1;',...
         'set(gmfpecvz,''Enable'',''on'');set(gmfpecvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Fin. pred. CV');
         
gmfpecv=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135+.27,hor-7*vys-.02,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmfpecv',...
   'String','');
            
gmfpecvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert+.27,hor-7*vys-.02,.13,.05], ...
          'Callback',['figure;plot(hhfp3,fpcv3,''r'');',...
          'title(''FPECV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
      
gmfpecvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215+.27,hor-7*vys-.02,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmfpecvset',...
   'String','');
      
%Shibata
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert,hor-8*vys-.03,.13,.05], ...
         'Callback',['set(gmscv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhs3,scv3,str3]=scvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmscv,''String'',CH);Inmat(4,3)=1;Inp(4,3)=1;',...
         'set(gmscvz,''Enable'',''on'');set(gmscvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Shibata CV');
         
gmscv=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135,hor-9*vys-.03,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmscv',...
   'String','');
            
gmscvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert,hor-9*vys-.03,.13,.05], ...
          'Callback',['figure;plot(hhs3,scv3,''r'');',...
          'title(''SCV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
      
gmscvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215,hor-9*vys-.03,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmscvset',...
   'String','');

%Rice     
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert,hor-10*vys-.04,.13,.05], ...
         'Callback',['set(gmrcv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhr3,rcv3,rtr3]=rcvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmrcv,''String'',CH);Inmat(5,3)=1;Inp(5,3)=1;',...
         'set(gmrcvz,''Enable'',''on'');set(gmrcvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Rice CV');
         
gmrcv=uicontrol( ...
	'Style','text', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135,hor-11*vys-.04,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmrcv',...
   'String','');
            
gmrcvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert,hor-11*vys-.04,.13,.05], ...
          'Callback',['figure;plot(hhr3,rcv3,''r'');',...
          'title(''RCV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
      
gmrcvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215,hor-11*vys-.04,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmrcvset',...
   'String','');
      
%Full       
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert,hor-12*vys-.05,.13,.05], ...
         'Callback',['set(gmfcv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhf3,fcv3,ftr3]=fcvgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmfcv,''String'',CH);Inmat(6,3)=1;Inp(6,3)=1;',...
         'set(gmfcvz,''Enable'',''on'');set(gmfcvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Full CV');
         
gmfcv=uicontrol( ...
	'Style','text', ...
    'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135,hor-13*vys-.05,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmfcv',...
   'String','');
            
gmfcvz=uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
          'Position',[vert,hor-13*vys-.05,.13,.05], ...
          'Callback',['figure;plot(hhf3,fcv3,''r'');',...
          'title(''FCV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
      
gmfcvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215,hor-13*vys-.05,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmfcvset',...
   'String','');

%Moje       
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.27,hor-10*vys-.04,.13,.05], ...
         'Callback',['set(gmkcv,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhk3,kcv3,ktr3]=kgm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmkcv,''String'',CH);Inmat(7,3)=1;Inp(7,3)=1;',...
         'set(gmkcvz,''Enable'',''on'');set(gmkcvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Kolacek CV');
         
gmkcv=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.135+.27,hor-11*vys-.04,tw,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmkcv',...
   'String','');
            
gmkcvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert+.27,hor-11*vys-.04,.13,.05], ...
          'Callback',['figure;plot(hhk3,kcv3,''r'');',...
          'title(''KCV dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
       
gmkcvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.215+.27,hor-11*vys-.04,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmkcvset',...
   'String','');
      
% Ostatni       
uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
         'Position',[vert+.26,hor-18*vys-.04,.28,.07], ...
         'Callback','Inmat=Inp;drallgm;',...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Draw all error functions');

uicontrol('Style','text','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.55,hor-18*vys-.06,.08,.07], ...
         'BackgroundColor',[.7 .7 .7],...
         'String','Actual h:');
     
acth=uicontrol('Style','text','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.63,hor-18*vys-.06,.08,.07], ...
         'HorizontalAlignment','left',...
         'BackgroundColor',[.7 .7 .7],...
         'String','none');
     
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.1,hor-16*vys,.3,.07], ...
         'Callback','Inmat=Inp;drallpengm;',...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Draw all penalizing functions');
      
%Odhsig frame
uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert,hor-17*vys-.04,.13,.05], ...
         'Callback',['set(gmsig,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhsig3,sigcv3]=siggm(x,y,n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmsig,''String'',CH);Inmat(9,3)=1;Inp(9,3)=1;',...
         'set(gmsigz,''Enable'',''on'');set(gmsigset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Mallows');
         
gmsig=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'Position',[vert+.135,hor-18*vys-.04,tw,.08], ...
   'HorizontalAlignment','left',...
   'BackgroundColor',[.7 .7 .7],...
   'Tag','gmsig',...
   'String','');
            
gmsigz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert,hor-18*vys-.04,.13,.05], ...
          'Callback',['figure;plot(hhsig3,sigcv3,''r'');',...
          'title(''Mallows dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       

gmsigset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',[.7 .7 .7],...
   'Position',[vert+.215,hor-18*vys-.04,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmsigset',...
   'String','');
      
%Chiu frame      
uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'Position',[vert+.55,hor-10*vys+.01+.09,.39,.24], ...
        'BackgroundColor',bcgcol);
     
uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'BackgroundColor',bcgcol,...
        'Position',[vert+.56,hor-4*vys-.005,.37,.04], ...
        'FontSize',12,...
        'FontUnits','normalized',...
        'String','Fourier');
     
 % First, the MiniCommand Window frame
    
    uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'Position',[vert+.6,hor-6*vys-.02+0.05,.3,.06], ...
	     'BackgroundColor',[0.50 0.50 0.50]);
%pause;
% Then the text label
    
uicontrol( ...
	     'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[vert+.615,hor-6*vys-.015+0.05,.14,.04], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
	     'ForegroundColor',[1 1 1], ...
        'String','Set constant c');
    
cHndl=uicontrol('Style','edit', ...
        'Units','normalized', ...
        'Max',1, ...
        'Min',1, ...
        'BackgroundColor',[1 1 1], ...
        'Position',[vert+.76,hor-6*vys+0.04,.12,.045], ...
        'FontUnits','normalized',...
        'String','2',...%%%%
        'HorizontalAlignment','left'); 
    
 chih=uicontrol('Style','push','Units','normalized', ...
         'FontUnits','normalized',...
         'Position',[vert+.62,hor-8*vys+0.065,.13,.05], ...
         'Callback',['set(gmchcv,''String'',''wait ...'');pause(.1);',...
         'c=str2num(get(cHndl,''string''));[h,g,hhch3,chcv3]=chgm(x,y,n,k,m,c);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmchcv,''String'',CH);Inmat(8,3)=1;Inp(8,3)=1;',...
         'set(gmchcvz,''Enable'',''on'');set(gmchcvset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Fourier');
         
gmchcv=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.76,hor-9*vys+.065,.14,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmchcv',...
   'String','');
            
gmchcvz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert+.62,hor-9*vys+.065,.13,.05], ...
          'Callback',['figure;plot(hhch3,chcv3,''r'');',...
          'title(''Fourier dependence on h for GM estimator'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       

gmchcvset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.84,hor-9*vys+.065,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmchcvset',...
   'String','');
            
%Plug-in frame     
uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'Position',[vert+.55,hor-16*vys-.03+.23,.39,.19], ...
        'BackgroundColor',bcgcol);
     
uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'BackgroundColor',bcgcol,...
        'Position',[vert+.56,hor-10*vys-.06-.11+.2,.37,.05], ...
        'FontSize',12,...
        'String','Plug-in');
pluginh=uicontrol('Style','push','Units','normalized', ...
        'FontUnits','normalized',...
         'Position',[vert+.62,hor-16*vys+.05+0.22,.13,.05], ...
         'Callback',['set(gmplugin,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhplugin,fplugin]=plugin(x,y,n,k,m,1);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmplugin,''String'',CH);Inmat(12,1:4)=1;Inp(12,1:4)=1;',...
         'set(gmpluginz,''Enable'',''on'');set(gmpluginset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'String','Plug-in');
gmplugin=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.76,hor-16*vys+.22,.13,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmplugin',...
   'String','');
            
gmpluginz=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert+.62,hor-16*vys+0.22,.13,.05], ...
          'Callback',['figure;plot(hhplugin,fplugin,''r'');',...
          'title(''Plug-in dependence on h'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
      
gmpluginset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.84,hor-16*vys+.22,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmpluginset',...
   'String','');
      
%MSE frame     
uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'Position',[vert+.55,hor-16*vys-.03,.39,.22], ...
        'BackgroundColor',bcgcol);
     
uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'BackgroundColor',bcgcol,...
        'Position',[vert+.56,hor-10*vys-.06-.11,.37,.04], ...
        'FontSize',12,...
        'String','MSE');
     
msewar=uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'BackgroundColor',bcgcol,...
        'Position',[vert+.56,hor-11*vys-.06-.1,.37,.04], ...
        'String','(Only for known regression function)');
     
mseh=uicontrol('Style','push','Units','normalized', ...
        'FontUnits','normalized',...
         'Position',[vert+.62,hor-16*vys+.035,.13,.05], ...
         'Callback',['set(gmmse,''String'',''wait ...'');pause(.1);',...
         '[h,g,hhmse,fmse]=mse(x,y,f,''t'',n,k,m);',...
         'CH=char([''= '',num2str(g,3)],[''h = '',num2str(h,4)]);',...
         'set(gmmse,''String'',CH);Inmat(10,1:4)=1;Inp(10,1:4)=1;',...
         'set(gmmsez,''Enable'',''on'');set(gmmseset,''Visible'',''on'');'],...   
         'BackgroundColor',[.5,0.5,0.5], ...
         'Enable','off',...
         'String','MSE');
      
if ff      
switch ~~exist('sym')
case {0}
   set(msewar,'String','No symbolic toolbox!','ForegroundColor','red');
case {1}
   set(mseh,'Enable','on');
end;
else
   set(msewar,'String','Unknown regression function!','ForegroundColor','red');
end;
      
gmmse=uicontrol( ...
	'Style','text', ...
   'Units','normalized', ...
   'FontUnits','normalized',...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.76,hor-16*vys-.015,.13,.08], ...
   'HorizontalAlignment','left',...
   'Tag','gmmse',...
   'String','');
            
gmmsez=uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[vert+.62,hor-16*vys-.015,.13,.05], ...
          'Callback',['figure;plot(hhmse,fmse,''r'');',...
          'title(''MSE dependence on h'');'],...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','draw',...
          'Enable','off');       
     
gmmseset=uicontrol( ...
	'Style','radiobutton', ...
   'FontUnits','normalized',...
   'Units','normalized', ...
   'BackgroundColor',bcgcol,...
   'Position',[vert+.84,hor-16*vys-.015,.04,.1], ...
   'Callback',callstr,...
   'Visible','off',...
   'Tag','gmmseset',...
   'String','');
     
uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[.84,.05,.14,.08], ...
          'Callback','close;', ...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','Close');
       
objects=get(gcf,'children');
set(objects,'FontUnits','normalized');
%set(gcf,'Units','Normalized','Position',[0 0.0347 1.0000 0.9190]);
set(gcf,'Units','Normalized','Position',[0.1059 0.1655 0.7700 0.6898]);
