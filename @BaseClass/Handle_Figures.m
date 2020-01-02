% [figureHandle] = Handle_Figures(BC) @ BaseClass
%
% will create new figure, use existing one or plots into exisiting subplot
% depeding on when it's used and if M.newFigPlotting is true
% also updates figure handle stored in the Maps and adds the entries to the
% M.oldFigureHandles property if you need them later.
% fig = get(groot,'CurrentFigure');
% h=findobj(fig,'type','axes');
% isSubplot = (size(h,1) > 1); % multiple axis in one figure, this smells like a subplot...
%
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function [figureHandle] = Handle_Figures(BC)
  % check if any figure handles were already stored and are still valid (not deleted)
  % they could be invisible as well, which is an important difference...
  validHandles = false(numel(BC.oldFigureHandles),1);
  for iFig = 1:numel(BC.oldFigureHandles)
    validHandles(iFig) = ~isempty(BC.oldFigureHandles{iFig}) && isvalid(BC.oldFigureHandles{iFig});
  end
  BC.oldFigureHandles = BC.oldFigureHandles(validHandles);

  % get current figure handle if one exists
  if ~isempty(BC.figureHandle) && isvalid(BC.figureHandle)
    oldHandleValid = true;
  else
    oldHandleValid = false;
  end

  % when newFigPlotting = false, only make new figure,
  % when there are no currently open and usable figures
  parent = get(groot,'CurrentFigure');
  figureExists = ~isempty(parent);
  if figureExists
    figureHasContent = ~isempty(parent.Children); % no axis means no content
  else
    figureHasContent = false;
  end

  if BC.newFigPlotting
    if figureExists && ~figureHasContent
      % we already have an open, empty figure, so don't make yet another one...
      BC.figureHandle = gcf;
      BC.figureHandle.Visible = BC.figureVisibility;
    elseif oldHandleValid
      % make new figure, store old figure
      BC.oldFigureHandles{end+1} = BC.figureHandle;
      BC.figureHandle = figure('Visible','off'); % also makes the new figure active automatically
    else
      % make new figure, no old figure to store
      BC.figureHandle = figure('Visible','off'); % also makes the new figure active automatically
    end

  else % screws things up when usings subplots, so just make sure to handle
    if ~figureExists
      BC.figureHandle = figure('Visible','off'); % also makes the new figure active automatically
    end 
      % BC.figureHandles correctly your self when using this option!
%     % do not plot in new figure newFigPlotting
%     if oldHandleValid
%       % make old figure active
%       figure(BC.figureHandle)
%     else
%       if figureExists
%         BC.figureHandle = gcf; % use existing figure, get that handle and store it
%       else
%         % make new figure as we don't have one yet
%         BC.figureHandle = figure(); % also makes the new figure active automatically
%       end
%     end
  end
  
  if ~isempty(BC.figureHandle)
     BC.figureHandle.Visible = BC.figureVisibility;
  end
  figureHandle = BC.figureHandle;
  set(0,'CurrentFigure', BC.figureHandle); % makes figure active but not visible
end
%
%
%   if figureExists && BC.newFigPlotting
%     BC.oldFigureHandles{end+1} = BC.figureHandle;

% %   if figureExists
% %     sibs = parent.Children;
% %     isSubplot = ~isempty(sibs) && isappdata(sibs(1),'SubplotPosition'); % only true if gcf is subplot figure
% %   else
% %     isSubplot = false;
% %   end
% %
% %   if isSubplot
% %     figureHandle = BC.figureHandle;
% %     figure(figureHandle);
% %     return; % just plot in current axis, as we are probably in a subplot...
% %   end
