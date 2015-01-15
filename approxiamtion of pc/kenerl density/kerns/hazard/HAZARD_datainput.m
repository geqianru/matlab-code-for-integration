function HAZARD_datainput


mf=findobj('Tag','HAZARD_MAIN');udata=get(mf,'UserData');X=udata.X;d=udata.d;
ddata=struct('X',X,'d',d);

datafig=figure( ...
   'Visible','on', ...
   'Name','Data Input', ...
   'Units','Normalized',...
   'Tag','HAZARD_DATA',...
   'NumberTitle','off');

set(datafig,'UserData',ddata);

uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.4,.875,.2,.1], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.5,...
        'String','Data Input');


% The LAOD1 button
LoadStr1='clear all;if exist(''HAZARD_tempsavedata.mat'')==2,load HAZARD_tempsavedata; save HAZARD_tempinputdata; prom=char(who);XVH=findobj(''Tag'',''XvarHndl'');dVH=findobj(''Tag'',''dvarHndl'');if length(prom)==0, prom=char(zeros(1,0)); else set(XVH,''Enable'',''on''); set(dVH,''Enable'',''on''); OKH=findobj(''Tag'',''OKvarHndl''); set(OKH,''Enable'',''on''); end, set(XVH,''String'',prom);set(dVH,''String'',prom);end';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,.65,.4,0.07], ...
        'String','Load data from workspace', ...
        'Callback',LoadStr1);

% The LAOD2 button
LoadStr2='clear all;uiload; save HAZARD_tempinputdata; prom=char(who);XVH=findobj(''Tag'',''XvarHndl'');dVH=findobj(''Tag'',''dvarHndl'');if length(prom)==0, prom=char(zeros(1,0)); else set(XVH,''Enable'',''on''); set(dVH,''Enable'',''on''); OKH=findobj(''Tag'',''OKvarHndl''); set(OKH,''Enable'',''on'');  end, set(XVH,''String'',prom); set(dVH,''String'',prom);';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,.55,.4,0.07], ...
        'String','Load data from file', ...
        'Callback',LoadStr2);




% Name of the random variable
    uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.6,.3,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.3,...
        'String','Name of the random variable (X):');

    prom=char(zeros(1,0));
    XvarHndl=uicontrol( ...
        'Tag','XvarHndl', ...
        'Style','popup', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.8,.6,.05,.1], ...
        'String',prom, ...
        'FontSize',0.3,...
        'Enable','off', ...
        'Callback','');
%        'CreateFcn',['x_def=',promdbl(1,:),';'],...
    
% Name of the censoring variable
    uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.5,.3,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.3,...
        'String','Name of the censoring variable (d):');

    prom=char(zeros(1,0));
    dvarHndl=uicontrol( ...
        'Tag','dvarHndl', ...
        'Style','popup', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.8,.5,.05,.1], ...
        'String',prom, ...
        'FontSize',0.3,...
        'Enable','off', ...
        'Callback','');
%        'CreateFcn',['x_def=',promdbl(1,:),';'],...
    

top=0.005;
% button OK
OKStr1='clear all; Xp=load(''HAZARD_tempinputdata'');  mf=findobj(''Tag'',''HAZARD_MAIN'');udata=get(mf,''UserData'');';
OKStr2='xvh=findobj(''Tag'',''XvarHndl'');Xval=get(xvh,''Value'');Xnames=get(xvh,''String'');callstr=[''udata.X=Xp.'',Xnames(Xval),'';''];eval(callstr);';
OKStr3='dvh=findobj(''Tag'',''dvarHndl'');dval=get(dvh,''Value'');dnames=get(dvh,''String'');callstr=[''udata.d=Xp.'',dnames(dval),'';''];eval(callstr);';
OKStr4='X=udata.X;  minX=min(X);maxX=max(X); DX=maxX-minX; xx=linspace(0,maxX+0.1*DX,201); bounds=[min(X),max(X)];udata.xx=xx;udata.bounds=bounds;set(mf,''UserData'',udata);';
OKStr5='LoH=udata.LoH;nL=length(LoH);for ii=3:6, set(LoH(ii),''Enable'',''on''); end,for ii=7:nL, set(LoH(ii),''Enable'',''off''); end;ca=get(mf,''CurrentAxes'');cla(ca,''reset''); delete HAZARD_tempinputdata.mat; set(gcf,''CloseRequestFcn'',''closereq'');close(gcf);clear all;';
    OKHndl=uicontrol( ...
        'Tag','OKvarHndl', ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top+0.025,.125,0.075], ...
        'String','OK', ...
        'Enable','off', ...
        'Callback',[OKStr1,OKStr2,OKStr3,OKStr4,OKStr5]);

% button Cancel
CancelStr='set(gcf,''CloseRequestFcn'',''closereq'');close(gcf);clear all;';
    CancelHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,top+0.025,.125,0.075], ...
        'String','Cancel', ...
        'Callback',CancelStr);


set(datafig,'Position',[0.1059 0.1655 0.7700 0.6898]);
