function HAZARD_randtool(action,flag)
%HAZARD_RANDTOOL Demonstration of many random number generators.
%   HAZARD_RANDTOOL creates a histogram of random samples from many
%   distributions. This is a demo that displays a histograms of random
%   samples from the distributions in the Statistics Toolbox. 
%
%   Change the parameters of the distribution by typing in a new
%   value or by moving a slider.
%
%   Export the current sample to a variable in the workspace by pressing
%   the export button.
%
%   Change the sample size by typing any positive integer in the
%   sample size edit box.
%
%   Change the distribution type using the popup menu.

%   Copyright 1993-2006 The MathWorks, Inc. and Jiri Zelinka, Masaryk University, Brno, Czech Republic
%   $Revision: 2.32.6.14 $  $Date: 2006/11/11 22:55:42 $


if nargin < 1
    action = 'start';
end

%On recursive calls get all necessary handles and data.
if ~strcmp(action,'start')   
   childList = allchild(0);
   rand_fig = childList(childList == gcf);
   ud = get(rand_fig,'Userdata');

   switch action
      case {'setpfield', 'setpslider', 'setphi', 'setplo'}
         ud = feval(action,flag,ud);
      case 'changedistribution', 
         ud = changedistribution(ud);
      case 'setsample',
         ud=updategui(ud,[]); 
      case 'output',
         X=ud.random_numbers;
	 save HAZARD_tempinputdata X;
         prom='X';
	 XVH=findobj('Tag','XvarHndl');
         set(XVH,'Enable','on'); 
	 OKH=findobj('Tag','OKvarHndl'); 
         set(OKH,'Enable','on'); 
         set(XVH,'String',prom);
         delete(gcf);
         return
      case 'cancel',
         X=[];
%         mf=findobj('Tag','HAZARD_MAIN');
         delete(gcf);
%         delete(daaf);
%         delete(mf);
%         ksdens(X);
         return
   end
   set(rand_fig,'UserData',ud);
end

% Initialize all GUI objects. Plot Normal HAZARD with sliders for parameters.
if strcmp(action,'start'),
   % Set positions of graphic objects
   axisp   = [.11 .35 .86 .58];

   pos = cell(7,3);
   pos{5,1} = [.10 .144 .08 .04];   % text
   pos{1,1} = [.19 .145 .12 .04];   % parameter
   pos{3,1} = [.19 .085 .12 .04];   % lower bound
   pos{4,1} = [.32 .085 .03 .16];   % slider
   pos{2,1} = [.19 .205 .12 .04];   % upper bound
   pos{7,1} = [.11 .085 .07 .05];   % lower bound label
   pos{6,1} = [.11 .205 .07 .05];   % upper bound label
   
   pos{5,2} = [.41 .144 .08 .04];   % text
   pos{1,2} = [.50 .145 .12 .04];   % parameter
   pos{3,2} = [.50 .085 .12 .04];   % lower bound
   pos{4,2} = [.63 .085 .03 .16];   % slider
   pos{2,2} = [.50 .205 .12 .04];   % upper bound
   pos{7,2} = [.42 .085 .07 .05];   % lower bound label
   pos{6,2} = [.42 .205 .07 .05];   % upper bound label
   
   pos{5,3} = [.72 .144 .08 .04];   % text
   pos{1,3} = [.81 .145 .12 .04];   % parameter
   pos{3,3} = [.81 .085 .12 .04];   % lower bound
   pos{4,3} = [.94 .085 .03 .16];   % slider
   pos{2,3} = [.81 .205 .12 .04];   % upper bound
   pos{7,3} = [.73 .085 .07 .05];   % lower bound label
   pos{6,3} = [.73 .205 .07 .05];   % upper bound label

   ud.dists = statguidists;
   dfltDist = find(strcmp('Normal',{ud.dists.name}));
   
   % Set axis limits and data
   rand_fig = figure('Tag', 'randfig', 'pos', [304 380 625 605], ...
                'visible', 'off','NumberTitle','off','IntegerHandle','off',...
                'Name','Random Number Generation Tool');
   figcolor  = get(rand_fig,'Color');
   set(rand_fig,'Units','Normalized','Backingstore','off');
   rand_axes = axes;
   xrange = getxdata(dfltDist,ud);
   set(rand_axes,'DrawMode','fast',...
      'Position',axisp,'XLim',xrange,'Box','on');
   set(rand_fig,'UserData',ud);

   % Define graphics objects
   for idx = 1:3
       nstr = int2str(idx);
       ud.pfhndl(idx) = uicontrol('Style','edit','Units','normalized','Position',pos{1,idx},...
          'String',num2str(ud.dists(dfltDist).parameters(2-rem(idx,2))),'BackgroundColor','white',...
          'CallBack',['HAZARD_randtool(''setpfield'',',nstr,')']);
         
       ud.hihndl(idx) = uicontrol('Style','edit','Units','normalized','Position',pos{2,idx},...
         'String',num2str(ud.dists(dfltDist).phi(2-rem(idx,2))),'BackgroundColor','white',...
         'CallBack',['HAZARD_randtool(''setphi'',',nstr,')']);
         
       ud.lohndl(idx) = uicontrol('Style','edit','Units','normalized','Position',pos{3,idx},...
         'String',num2str(ud.dists(dfltDist).plo(2-rem(idx,2))),'BackgroundColor','white',... 
         'CallBack',['HAZARD_randtool(''setplo'',',nstr,')']);

       ud.pslider(idx) = uicontrol('Style','slider','Units','normalized','Position',pos{4,idx},...
         'Value',ud.dists(dfltDist).parameters(2-rem(idx,2)),'Max',ud.dists(dfltDist).phi(2-rem(idx,2)),...
         'Min',ud.dists(dfltDist).plo(2-rem(idx,2)),'Callback',['HAZARD_randtool(''setpslider'',',nstr,')']);

       ud.ptext(idx) = uicontrol('Style','text','Units','normalized','Position',pos{5,idx},...
         'BackgroundColor',figcolor,'ForegroundColor','k','String',ud.dists(dfltDist).paramnames{2-rem(idx,2)});
       
       ud.lowerboundtext(idx) = uicontrol('Style','text','Units','normalized', ...
         'Position', pos{7,idx},...
         'ForegroundColor','k','BackgroundColor',figcolor,'String', 'Lower bound' ); 
   
       ud.upperboundtext(idx) = uicontrol('Style','text','Units','normalized', ...
         'Position', pos{6,idx},...
         'ForegroundColor','k','BackgroundColor',figcolor,'String', 'Upper bound'); 

       setincrement(ud.pslider(idx), ud.dists(dfltDist).intparam(2-rem(idx,2)));
   end      
   
   enableParams(ud, 3, 'off');

   distNameList = sprintf('%s|',ud.dists.name);
   ud.popup=uicontrol('Style','Popup','String',distNameList(1:end-1),...
        'Units','normalized','Position',[.28 .945 .25 .04],'UserData','popup','Value',dfltDist,...
        'BackgroundColor','white',...
        'CallBack','HAZARD_randtool(''changedistribution'')');

   ud.samples_field = uicontrol('Style','edit','Units','normalized',...
         'Position',[.71 .945 .15 .04], 'String','100',...
         'BackgroundColor','white',...
         'CallBack','HAZARD_randtool(''setsample'',1)');

   uicontrol('Style','Pushbutton',...
         'Units','normalized','Position',[.70 .02 .13 .04],...
         'Callback','HAZARD_randtool(''setsample'',1)','String','Resample');

   uicontrol('Style','Pushbutton','Units','normalized',...
         'Position',[.84 .02 .13 .04],...
         'Callback','HAZARD_randtool(''output'',2);','String','Save');

   uicontrol('Style','Pushbutton','Units','normalized',...
         'Position',[.1 .02 .13 .04],...
         'Callback','HAZARD_randtool(''cancel'',2);','String','Cancel');

   ud = updategui(ud,[]);
   set(rand_fig,'visible','on'); % need to do this before calling placetitlebar
   placetitlebar(rand_fig);
   set(rand_fig,'UserData',ud,'HandleVisibility','callback',...
       'InvertHardCopy', 'on', 'PaperPositionMode', 'auto')
   drawnow;
end % End of initialization.

% END OF HAZARD_randtool MAIN FUNCTION.

% ==== Begin helper functions ====

%------------------------------------------------------------------------------
% Supply x-axis range for each distribution. GETXDATA
function xrange = getxdata(popupvalue,ud)
phi = ud.dists(popupvalue).phi;
plo = ud.dists(popupvalue).plo;
switch ud.dists(popupvalue).rvname
    case 'betarv', % Beta 
       xrange  = [0 1];
    case 'binorv', % Binomial 
       xrange  = [-.5 phi(1)+.5];
	case 'chi2rv', % Chi-square
       xrange  = [0 phi + 4 * sqrt(2 * phi)];
    case 'unidrv', % Discrete Uniform
       xrange  = [0.5 phi+.5];
    case 'exprv', % Exponential
       xrange  = [0 4*phi];
    case 'evrv', % Extreme Value
       xrange = [plo(1)-5*phi(2), phi(1)+2*phi(2)];
    case 'frv', % F 
       xrange  = [0 finv(0.995,plo(1),plo(1))];
    case 'gamrv', % Gamma
       hixvalue = phi(1) * phi(2) + 4*sqrt(phi(1) * phi(2) * phi(2));
       xrange  = [0 hixvalue];
    case'gevrv', % Generalized Extreme Value
       loxvalue = gevinv(0.01,plo(1),phi(2),plo(3));
       hixvalue = gevinv(0.99,phi(1),phi(2),phi(3));
       xrange  = [loxvalue-0.5 hixvalue+.5];       
    case 'gprv', % Generalized Pareto
       hixvalue = gpinv(0.99,phi(1),phi(2),phi(3));
       xrange  = [plo(3)-0.5 hixvalue+.5];       
    case 'georv', % Geometric
       hixvalue = geoinv(0.99,plo(1));
       xrange  = [-0.5 hixvalue+.5];       
    case 'lognrv', % Lognormal
       xrange = [0 logninv(0.99,phi(1),phi(2))];
    case 'nbinrv', % Negative Binomial
       xrange = [-0.5 nbininv(0.99,phi(1),plo(2))+.5];
    case 'ncfrv', % Noncentral F
       xrange = [0 phi(3)+30];
    case 'nctrv', % Noncentral T
       xrange = [phi(2)-14 phi(2)+14];
    case 'ncx2rv', % Noncentral Chi-square
       xrange = [0 phi(2)+30];
    case 'normrv', % Normal
       xrange   = [plo(1) - 3 * phi(2) phi(1) + 3 * phi(2)];
    case 'poissrv', % Poisson
      xrange  = [-0.5 4*phi(1)+.5];
    case 'raylrv', % Rayleigh
       xrange = [0 raylinv(0.995,phi(1))];
    case 'trv', % T
       lowxvalue = tinv(0.005,plo(1));
       xrange  = [lowxvalue -lowxvalue];
    case 'unifrv', % Uniform
       xrange  = [plo(1) phi(2)];
    case 'weibrv', % Weibull
       xrange  = [0 wblinv(0.995,plo(1),plo(2))];
end


%-----------------------------------------------------------------------------
% Determine validity of value with respect to min and max
function valid = okwithminmax(cv, pmin, pmax, popupvalue, fieldnum, ud)

if ~isreal(cv) || ~isreal(pmin) || ~isreal(pmax)
    valid = false

% All parameters may be in the open interval (pmin, pmax)
elseif (pmin < cv) && (cv < pmax)
    valid = true;
    
else
    valid = false;
    rvname = ud.dists(popupvalue).rvname;
    paramname = lower(ud.dists(popupvalue).paramnames{fieldnum});
    
    % Binomial p may also be in the closed interval [pmin, pmax]
    if  (isequal(rvname, 'binorv') && isequal(paramname,'prob')) ...
        if (pmin <= cv) &&  (cv <= pmax)
            valid = true;
        end
        
    % NC Chi-sq and F delta may also be in half-open interval [pmin, pmax)
    elseif  (isequal(rvname, 'ncx2rv') && isequal(paramname,'delta')) ...
         || (isequal(rvname, 'ncfrv')  && isequal(paramname,'delta'))
        if (pmin <= cv) &&  (cv < pmax)
            valid = true;
        end
    end
end


%-----------------------------------------------------------------------------
% For uniform, pvalue "max" must be greater than pvalue "min"
function ok = uniformcheckok(popupvalue, cv, fieldno, ud)
ok = true;
if isequal(ud.dists(popupvalue).rvname, 'unifrv')
    paramname = lower(ud.dists(popupvalue).paramnames{fieldno});
    if isequal(paramname, 'min')
%         pv = str2double(get(ud.pfhndl(2),'String'));
        pv = ud.dists(popupvalue).parameters(2);
        if cv >= pv
            ok = false;
        end
    else %if isequal(paramname, 'max')
%         pv = str2double(get(ud.pfhndl(1),'String'));
        pv = ud.dists(popupvalue).parameters(1);
        if cv <= pv
            ok = false;
        end
    end
end


%------------------------------------------------------------------------------
% set sliders to use integer or continuous values as appropriate
function setincrement(pslider, intparam)
ss = [0.01 0.1];       % MATLAB default
if (intparam)
   d = max(1, get(pslider,'Max') - get(pslider,'Min'));

   ss = max(1, round(ss * d));
   if (ss(2) <= ss(1)), ss(2) = ss(1) + 1; end
   ss = ss ./ d;
end

set(pslider, 'SliderStep', ss);


%------------------------------------------------------------------------------
% Enable or disable a GUI object
function enableParams(ud, p, state)
if strcmp(state, 'off')
    color =  [0.831373 0.815686 0.784314];
    set(ud.pfhndl(p),'String', '');
    set(ud.hihndl(p),'String', '');
    set(ud.lohndl(p),'String', '');
    set(ud.ptext(p),'String', '');
else
    color = 'white';
end
set(ud.pfhndl(p),'Enable', state, 'Backgroundcolor', color);
set(ud.hihndl(p),'Enable', state, 'Backgroundcolor', color);
set(ud.lohndl(p),'Enable',state, 'Backgroundcolor', color);
set(ud.pslider(p),'Enable', state);
set(ud.ptext(p),'Enable',state);
set(ud.lowerboundtext(p),'Enable',state);
set(ud.upperboundtext(p),'Enable',state);

% End helper functions

% BEGIN CALLBACK FUNCTIONS.

%------------------------------------------------------------------------------
% Callback for changing probability distribution function. CHANGEDISTRIBUTION
function ud = changedistribution(ud)

popupvalue = get(ud.popup,'Value');
parameters = ud.dists(popupvalue).parameters;
phi        = ud.dists(popupvalue).phi;
plo        = ud.dists(popupvalue).plo;
paramnames = ud.dists(popupvalue).paramnames;
intparam   = ud.dists(popupvalue).intparam;

nparams = length(parameters);
enableParams(ud, 1:nparams, 'on');
if nparams < 3
    enableParams(ud, (nparams+1):3, 'off');
end

for idx = 1:nparams
    set(ud.ptext(idx),'String',paramnames{idx});
    set(ud.pfhndl(idx),'String',num2str(parameters(idx)));
    set(ud.lohndl(idx),'String',num2str(plo(idx)));
    set(ud.hihndl(idx),'String',num2str(phi(idx)));
    set(ud.pslider(idx),'Min',plo(idx),'Max',phi(idx),'Value',parameters(idx));
    setincrement(ud.pslider(idx), intparam(idx));
end

xrange = getxdata(popupvalue,ud);
set(gca,'Xlim',xrange);

ud=updategui(ud,xrange);


%------------------------------------------------------------------------------
% Callback for controlling lower bound of the parameters using editable text boxes.
function ud = setplo(fieldno,ud)
popupvalue = get(ud.popup,'Value');
intparam = ud.dists(popupvalue).intparam(fieldno);
fieldentry = get(ud.lohndl(fieldno),'String');
cv   = str2double(fieldentry);

pv = str2double(get(ud.pfhndl(fieldno),'String'));
cmax = str2double(get(ud.hihndl(fieldno),'String'));

if intparam
    cv = round(cv);
    set(ud.lohndl(fieldno),'String',num2str(cv));
end
badval = false;

% if the proposed lower limit is larger then the current upper limit, no good
if cv >= cmax
  badval = true;
  
% if the proposed lower limit is smaller than the current upper limit but
% larger then the current value, it must be ok, except for the cross check
% needed for the uniform distribution
elseif cv > pv
  if uniformcheckok(popupvalue, cv, fieldno, ud)
      set(ud.pslider(fieldno),'Min',cv);
      ud.dists(popupvalue).plo(fieldno) = cv;
      set(ud.pfhndl(fieldno),'String',num2str(cv));
      ud = setpfield(fieldno,ud);
  else
      badval = true;
  end
  
% else we need to check if it's larger then the minimum allowed value
else
  pmin = ud.dists(popupvalue).pmin(fieldno);
  pmax = ud.dists(popupvalue).pmax(fieldno);
  if okwithminmax(cv, pmin, pmax, popupvalue, fieldno, ud)
    set(ud.pslider(fieldno),'Min',cv);
    ud.dists(popupvalue).plo(fieldno) = cv;
  else
    badval = true;
  end
end
setincrement(ud.pslider(fieldno), intparam);
xrange = getxdata(popupvalue,ud);
ud = updategui(ud,xrange);

if badval
    preventry = num2str(ud.dists(popupvalue).plo(fieldno));
    wmsg = sprintf('Bad lower bound value "%s", resetting to "%s"', ...
                   fieldentry, preventry);
    uiwait(warndlg(wmsg, 'RANDTOOL', 'modal'))
    set(ud.lohndl(fieldno),'String',preventry);
end


%------------------------------------------------------------------------------
% Callback for controlling upper bound of the parameters using editable text boxes.
function ud = setphi(fieldno,ud)
popupvalue = get(ud.popup,'Value');
intparam = ud.dists(popupvalue).intparam(fieldno);
fieldentry = get(ud.hihndl(fieldno),'String');
cv   = str2double(fieldentry);
pv = str2double(get(ud.pfhndl(fieldno),'String'));
cmin = str2double(get(ud.lohndl(fieldno),'String'));

if intparam
    cv = round(cv);
    set(ud.hihndl(fieldno),'String',num2str(cv));
end

badval = false;

% if the proposed upper limit is samller then the current lower limit, no good
if cv <= cmin
  badval = true;
  
% if the proposed upper limit is larger than the current lower limit but
% smaller then the current value, it must be ok, except for the cross check
% needed for the uniform distribution
elseif cv < pv
  if uniformcheckok(popupvalue, cv, fieldno, ud)
      set(ud.pslider(fieldno),'Max',cv);
      ud.dists(popupvalue).phi(fieldno) = cv;
      set(ud.pfhndl(fieldno),'String',num2str(cv));
      ud = setpfield(fieldno,ud);
  else
      badval = true;
  end
  
% else we need to check if it's smaller then the maximum allowed value
else
  pmin = ud.dists(popupvalue).pmin(fieldno);
  pmax = ud.dists(popupvalue).pmax(fieldno);
  if okwithminmax(cv, pmin, pmax, popupvalue, fieldno, ud)
    set(ud.pslider(fieldno),'Max',cv);
    ud.dists(popupvalue).phi(fieldno) = cv;
  else
    badval = true;
  end
end
setincrement(ud.pslider(fieldno), intparam);
xrange = getxdata(popupvalue,ud);
ud=updategui(ud,xrange);

if badval
    preventry = num2str(ud.dists(popupvalue).phi(fieldno));
    wmsg = sprintf('Bad upper bound value "%s", resetting to "%s"', ...
                   fieldentry, preventry);
    uiwait(warndlg(wmsg, 'RANDTOOL', 'modal'))
    set(ud.hihndl(fieldno),'String',preventry);
end


%------------------------------------------------------------------------------
% Callback for controlling the parameter values using sliders.
function ud = setpslider(sliderno,ud)

% turn off this callback in case we have to put up a warning dialog
cbstr = get(ud.pslider(sliderno),'Callback');
set(ud.pslider(sliderno),'Callback',[]);

errstr = [];
try
    popupvalue = get(ud.popup,'Value');
    intparam = ud.dists(popupvalue).intparam(sliderno);

    cv = get(ud.pslider(sliderno),'Value');
    if intparam
        cv = round(cv);
    end

    set(ud.pfhndl(sliderno),'String',num2str(cv));

    if uniformcheckok(popupvalue, cv, sliderno, ud)
        ud.dists(popupvalue).parameters(sliderno) = cv;
    else % handle a conflict between the min and max params for the uniform distribution
        pv = ud.dists(popupvalue).parameters(sliderno);
        preventry = num2str(pv);
        wmsg = sprintf('Bad parameter value "%s", resetting to "%s"', ...
            num2str(cv), preventry);
        uiwait(warndlg(wmsg, 'RANDTOOL', 'modal'))
        set(ud.pslider(sliderno),'Value',pv);
        set(ud.pfhndl(sliderno),'String',preventry);
    end
    ud=updategui(ud,[]);
catch
    errstr = lasterror;
end

% turn this callback back on after warning dialog dismissed
set(ud.pslider(sliderno),'Callback',cbstr);
if ~isempty(errstr)
    rethrow(errstr);
end


%------------------------------------------------------------------------------
% Callback for the parameter value editable text boxes.
function ud = setpfield(fieldno,ud)
popupvalue = get(ud.popup,'Value');
intparam = ud.dists(popupvalue).intparam(fieldno);
fieldentry = get(ud.pfhndl(fieldno),'String');
cv = str2double(fieldentry);
if isnan(cv) || ~isreal(cv)
    goodval = false;
else
    goodval = true;
    pmin = ud.dists(popupvalue).pmin(fieldno);
    pmax = ud.dists(popupvalue).pmax(fieldno);
%     phivalue = str2double(get(ud.hihndl(fieldno),'String'));
%     plovalue = str2double(get(ud.lohndl(fieldno),'String'));
    phivalue = ud.dists(popupvalue).phi(fieldno);
    plovalue = ud.dists(popupvalue).plo(fieldno);
end

if goodval && intparam
    cv = round(cv);
    set(ud.pfhndl(fieldno),'String',num2str(cv));
end
if goodval && uniformcheckok(popupvalue, cv, fieldno, ud) && ... 
              okwithminmax(cv, pmin, pmax, popupvalue, fieldno, ud)
    set(ud.pslider(fieldno),'Value',cv);
    ud.dists(popupvalue).parameters(fieldno) = cv;
    if (cv >= phivalue), 
        set(ud.hihndl(fieldno),'String',num2str(cv));
        ud = setphi(fieldno,ud); 
        set(ud.pslider(fieldno),'Max',cv);
        setincrement(ud.pslider(fieldno), intparam);
        return; % this return is to avoid using updategui twice.
    end
    if (cv <= plovalue), 
        set(ud.lohndl(fieldno),'String',num2str(cv));
        ud = setplo(fieldno,ud); 
        set(ud.pslider(fieldno),'Min',cv);
        setincrement(ud.pslider(fieldno), intparam);
        return; 
    end
else
    preventry = num2str(ud.dists(popupvalue).parameters(fieldno));
    set(ud.pfhndl(fieldno),'String',preventry);
    wmsg = sprintf('Bad parameter value "%s", resetting to "%s"', ...
                   fieldentry, preventry);
    uiwait(warndlg(wmsg, 'RANDTOOL', 'modal'))
end
if goodval
   xrange = getxdata(popupvalue,ud);
   updategui(ud, xrange);
end


%------------------------------------------------------------------------------
% Callback to update graphic objects in GUI.
function ud=updategui(ud,xrange)

if isempty(xrange)
   xrange = get(gca,'Xlim');
end

popupvalue = get(ud.popup,'Value');

name = ud.dists(popupvalue).name;
if strcmpi(name,'weibull')  % use new name to avoid warning
   name = 'wbl';
end
nparams = length(ud.dists(popupvalue).parameters);
samples = str2double(get(ud.samples_field,'String'));
if isnan(samples) || samples<=0 || samples~=floor(samples) || ~isreal(samples)
    wmsg = 'Sample size must be a positive integer. It will be reset to its default value of 100.';
    uiwait(warndlg(wmsg, 'RANDTOOL', 'modal'))
    samples = 100;
    set(ud.samples_field,'String','100');
end

% pval = cell(1,nparams);
% for idx = 1:nparams
%     pval{idx} = str2double(get(ud.pfhndl(idx),'String'));
% end
pval = num2cell(ud.dists(popupvalue).parameters);

set(gcf,'Pointer','watch');
errstr = [];
try
   random_numbers = random(name,pval{:},samples,1);
   ud.random_numbers = random_numbers;

   % Create Histogram
   minrn = min(random_numbers);
   maxrn = max(random_numbers);
   if ud.dists(popupvalue).discrete
       edges = minrn-0.5:1:(maxrn+.5); % bins centered on the integers
   else
       bins = floor(sqrt(samples));
       if bins > 1
           edges = linspace(minrn,maxrn+eps(maxrn),bins+1);
       else
           edges = [minrn, minrn+1]; % single bin one unit wide
       end
   end
   counts = histc(random_numbers,edges);
   bar(edges,counts,'histc');

   set(gca,'XLim',xrange, 'XTickMode','auto', 'XTickLabelMode','auto');

   text(-0.08, 0.45,'Counts','Unit','Normalized','EraseMode','none', 'rotation', 90);
   text(0.45,-0.10,'Values','Unit','Normalized','EraseMode','none');
   text(0.55, 1.06,'Samples','Unit','Normalized','EraseMode','none');
   text(0.01, 1.06,'Distribution','Unit','Normalized','EraseMode','none');

catch
   errstr = lasterror;
end
set(gcf,'Pointer','arrow');
if ~isempty(errstr)
   error('stats:HAZARD_randtool:GeneratorError',...
         'Error occurred while generating random sample.\n%s',errstr.message);
end


%------------------------------------------------------------------------------
function placetitlebar(fig)
%PLACETITLEBAR ensures that a figure's titlebar is on screen.
%
%   Copyright 1993-2004 The MathWorks, Inc. 
%   $Revision: 1.1.4.1 $  $Date: 2004/01/24 09:36:24 $

oldRootUnits = get(0, 'Units');
oldFigUnits = get(fig, 'Units');

set(0, 'Units', 'pixels');
set(fig, 'Units', 'pixels');
   
screenpos = get(0, 'Screensize');
outerpos = get(fig, 'Outerposition');
if outerpos(2) + outerpos(4) > screenpos(4)
    outerpos(2) = screenpos(4) - outerpos(4);
    set(fig, 'Outerposition', outerpos);
end
%restore units
set(0, 'Units', oldRootUnits);
set(fig, 'Units', oldFigUnits);


%------------------------------------------------------------------------------

function dists = statguidists
%STATGUIDISTS Distribution data for RANDTOOL and DISTTOOL

% The name field is used both to display the distribution, and as an argument
% to the HAZARD, PDF, IHAZARD, and RANDOM functions.  The rvname field is used
% internally to identify a distribution given its position in this structure,
% and is also used in RANDTOOL as a workspace variable name.
%
% The pmin and pmax fields give the theoretical limits for the parameters,
% while the plo(>=pmin) and phi(<=pmax) fields give the currently enforced
% limits.

%   Copyright 1993-2005 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2005/11/18 14:28:51 $

i = 0;
i = i+1; dists(i) = struct('name','Beta', ...
                           'rvname','betarv', ...
                           'discrete', 0, ...
                           'paramnames',{{'A','B'}}, ...
                           'parameters', [2 2], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [0 0], ...
                           'phi', [4 4], ...
                           'plo', [0.5 0.5], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Binomial', ...
                           'rvname','binorv', ...
                           'discrete', 1, ...
                           'paramnames',{{'Trials','Prob'}}, ...
                           'parameters', [10 0.5],  ...
                           'pmax', [Inf 1], ...
                           'pmin', [0 0], ...
                           'phi', [10 1], ...
                           'plo', [1 0], ...
                           'intparam', [1 0]);
i = i+1; dists(i) = struct('name','Chisquare', ...
                           'rvname','chi2rv', ...
                           'discrete', 0, ...
                           'paramnames',{{'df'}}, ...
                           'parameters', 2, ...
                           'pmax', Inf, ...
                           'pmin', 0, ...
                           'phi', 10, ...
                           'plo', 1, ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Discrete Uniform', ...
                           'rvname','unidrv', ...
                           'discrete', 1, ...
                           'paramnames',{{'Number'}}, ...
                           'parameters', 20, ...
                           'pmax', Inf, ...
                           'pmin', 0, ...
                           'phi', 20, ...
                           'plo', 1, ...
                           'intparam', [1 0]);
i = i+1; dists(i) = struct('name','Exponential', ...
                           'rvname','exprv', ...
                           'discrete', 0, ...
                           'paramnames',{{'Mu'}}, ...
                           'parameters', 1,  ...
                           'pmax', Inf, ...
                           'pmin', 0, ...
                           'phi', 2, ...
                           'plo', 0.5, ...
                           'intparam', [0]);
i = i+1; dists(i) = struct('name','Extreme Value', ...
                           'rvname','evrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'Mu','Sigma'}}, ...
                           'parameters', [0 1], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [-Inf 0], ...
                           'phi', [5 2], ...
                           'plo', [-5 .5], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','F', ...
                           'rvname','frv', ...
                           'discrete', 0, ...
                           'paramnames',{{'df1','df2'}}, ...
                           'parameters', [5 5], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [0 0], ...
                           'phi', [10 10], ...
                           'plo', [5 5], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Gamma', ...
                           'rvname','gamrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'A','B'}}, ...
                           'parameters', [2 2], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [0 0], ...
                           'phi', [5 5], ...
                           'plo', [2 2], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Generalized Extreme Value', ...
                           'rvname','gevrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'K','Sigma','Mu'}}, ...
                           'parameters', [0 1 0], ...
                           'pmax', [Inf Inf Inf], ...
                           'pmin', [-Inf 0 -Inf], ...
                           'phi', [.25 2 2], ...
                           'plo', [-0.5 0.5 -2], ...
                           'intparam', [0 0 0]);
i = i+1; dists(i) = struct('name','Generalized Pareto', ...
                           'rvname','gprv', ...
                           'discrete', 0, ...
                           'paramnames',{{'K','Sigma','Theta'}}, ...
                           'parameters', [0 1 0], ...
                           'pmax', [Inf Inf Inf], ...
                           'pmin', [-Inf 0 -Inf], ...
                           'phi', [.25 2 2], ...
                           'plo', [-0.25 0.5 -2], ...
                           'intparam', [0 0 0]);
i = i+1; dists(i) = struct('name','Geometric', ...
                           'rvname','georv', ...
                           'discrete', 1, ...
                           'paramnames',{{'Prob'}}, ...
                           'parameters', 0.5, ...
                           'pmax', 1, ...
                           'pmin', 0, ...
                           'phi', 0.99, ...
                           'plo', 0.25, ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Lognormal', ...
                           'rvname','lognrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'Mu','Sigma'}}, ...
                           'parameters', [0.5 0.25], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [-Inf 0], ...
                           'phi', [1 0.3], ...
                           'plo', [0 0.1], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Negative Binomial', ...
                           'rvname','nbinrv', ...
                           'discrete', 1, ...
                           'paramnames',{{'R','Prob'}}, ...
                           'parameters', [2 0.6], ...
                           'pmax', [Inf 1], ...
                           'pmin', [0 0], ...
                           'phi', [3 0.99], ...
                           'plo', [1 0.5], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Noncentral F', ...
                           'rvname','ncfrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'df1','df2','Delta'}}, ...
                           'parameters', [5 5 1], ...
                           'pmax', [Inf Inf Inf], ...
                           'pmin', [0 0 0], ...
                           'phi', [10 10 5], ...
                           'plo', [5 5 0], ...
                           'intparam', [0 0 0]);
i = i+1; dists(i) = struct('name','Noncentral T', ...
                           'rvname', 'nctrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'df','delta'}}, ...
                           'parameters', [5 1], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [0 -Inf], ...
                           'phi', [10 5], ...
                           'plo', [2 0], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Noncentral Chi-square', ...
                           'rvname', 'ncx2rv', ...
                           'discrete', 0, ...
                           'paramnames',{{'df','delta'}}, ...
                           'parameters', [5 1], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [0 0], ...
                           'phi', [10 5], ...
                           'plo', [2 0], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Normal', ...
                           'rvname', 'normrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'Mu','Sigma'}}, ...
                           'parameters', [0 1], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [-Inf 0], ...
                           'phi', [2 2], ...
                           'plo', [-2 0.5], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Poisson', ...
                           'rvname', 'poissrv', ...
                           'discrete', 1, ...
                           'paramnames',{{'Lambda'}}, ...
                           'parameters', 5, ...
                           'pmax', Inf, ...
                           'pmin', 0, ...
                           'phi', 5, ...
                           'plo', 1, ...
                           'intparam', [0]);
i = i+1; dists(i) = struct('name','Rayleigh', ...
                           'rvname', 'raylrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'B'}}, ...
                           'parameters', 2, ...
                           'pmax', Inf, ...
                           'pmin', 0, ...
                           'phi', 5, ...
                           'plo', 1, ...
                           'intparam', [0]);
i = i+1; dists(i) = struct('name','T', ...
                           'rvname', 'trv', ...
                           'discrete', 0, ...
                           'paramnames',{{'df'}}, ...
                           'parameters', 5, ...
                           'pmax', Inf, ...
                           'pmin', 0, ...
                           'phi', 10, ...
                           'plo', 2, ...
                           'intparam', [0]);
i = i+1; dists(i) = struct('name','Uniform', ...
                           'rvname', 'unifrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'Min','Max'}}, ...
                           'parameters', [0 1], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [-Inf -Inf], ...
                           'phi', [0.5 2], ...
                           'plo', [0 1], ...
                           'intparam', [0 0]);
i = i+1; dists(i) = struct('name','Weibull', ...
                           'rvname', 'weibrv', ...
                           'discrete', 0, ...
                           'paramnames',{{'A','B'}}, ...
                           'parameters', [1 2], ...
                           'pmax', [Inf Inf], ...
                           'pmin', [0 0], ...
                           'phi', [3 3], ...
                           'plo', [.5 .5], ...
                           'intparam', [0 0]);

% END CALLBACK FUNCTIONS.
