% non functional example class to be used as basis for new hardware interfacing
% class, as they alls should have similar structure and content

classdef (Abstract) BaseClass < handle
  % BaseClass Description goes here!

  properties
    % parallel settings --------------------------------------------------------
    runInParallel(1,1) {mustBeNumericOrLogical} = 0;   % run parfor instead of for loops where faster
    nWorkers(1,1) {mustBeNumeric} = 0; % 0 = use default number of workes, >0 is nWorkers

    % keep certain raw data in cache?
    % if enabled, significantly speeds up repeated processing of the same file
    % at the cost of keeping the raw data in memory!
    cacheRawData(1,1) {mustBeNumericOrLogical} = false;
    % has raw data been rawDataCached?
    rawDataIsCached(1,1) {mustBeNumericOrLogical} = false;
    cacheID;
      % some sort of unique identifier to make sure cached data is data we want
      % typically, full file path is a good ID

    % properties controling default plotting behaviour
    newFigPlotting(1,1) {mustBeNumericOrLogical} = true; % default open all plots in new figure
    noAxis(1,1) {mustBeNumericOrLogical} = false; % plot w/o axis
    noColorBar(1,1) {mustBeNumericOrLogical} = true; % plot w/o colorbar
    drawNow(1,1) {mustBeNumericOrLogical} = true; % call drawnow when done with plotting?

    colorMap(:,3) {mustBeNumeric} = hot(256);
    color(1,3) {mustBeNumeric} = [0.0, 0.6, 0.0]; % dark green
    figureHandle; % figure handle to use for next plot
  end

  properties (Access = private)
    % properties controlling degree of processing output -----------------------
    silent(1,1) {mustBeNumericOrLogical};
      % when silent = true, nothing is output or plotted, vebose output saved to log file
    % verboseOutput(1,1) {mustBeNumericOrLogical}; % more detailed output to workspace...
    % verbosePlotting(1,1) {mustBeNumericOrLogical}; % more figures...
    % figureVisibility(1,:) char {mustBeMember(figureVisibility,{'on','off',''})};
  end

  % depended properties are calculated from other properties
  properties (Dependent = true)
    outId; % used for fprintf 1 for workspace, 2 for standard error, or file id
    totalByteSize; % calculate based on class handle?
  end

  % things we don't want to accidently change but that still might be interesting
  properties(SetAccess = private)
    oldFigureHandles; % when plotting in new figure, store old figure handle here
  end

  % things we don't want to accidently change but that still might be interesting
  properties(Constant)
    FONT_SIZE = 12;
    LINE_WIDTH = 1.5;
  end

  % same as constant but now showing up as property
  properties (Hidden=true)
    logFilePath = [getuserdir '\fsp_log.txt'];
  end


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % constructor, desctructor, save obj
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  methods
    % constructor, called when class is created
    function BC = BaseClass()
      % set default style, so that plotting is consistent...
      set(0,'DefaultAxesFontSize',BC.FONT_SIZE);
      set(0,'DefaultTextFontSize',BC.FONT_SIZE);
      set(0,'DefaultLineLinewidth',BC.LINE_WIDTH);
      format compact;
      set(0,'defaultfigurecolor',[1 1 1]);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function delete(BC)
      global globalOutId;
      % close connections etc
      logFileIsOpen = ~isempty(BC.outId) && (BC.outId > 2) && ~isempty(fopen(BC.outId));
      if logFileIsOpen
        % fprintf('Closed open connection to log file.\n')
        fclose(BC.outId);
        globalOutId = [];
      end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % when saved, hand over only properties stored in saveObj
    function SaveObj = saveobj(BC)
      % only save public properties of the class if you save it to mat file
      % without this saveobj function you will create an error when trying
      % to save this class
      % SaveObj.pos = BC.pos;
      SaveObj = BC; % just copy/save all for now
     end
  end


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  methods % short methods, which are not worth putting in a file
    % Done(BC);
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  methods (Access = private)
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  methods (Abstract)
  end % <<<<<<<< END SET?GET METHODS

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  methods % set / get methods
    %%===========================================================================
    function totalByteSize = get.totalByteSize(BC)
      totalByteSize = get_handle_class_size(BC);
    end

    %%===========================================================================
    function outId = get.outId(BC)
      global globalOutId;
      if ~BC.silent %normal fprint output
        outId = 1;
      elseif isempty(globalOutId) || globalOutId < 2
        outId = fopen(BC.logFilePath,'at');
      else
        outId = globalOutId;
      end
      globalOutId = outId;
    end

    %%===========================================================================
    function set.outId(~,newId)
      global globalOutId;
      globalOutId = newId;
    end
  end % <<<<<<<< END SET?GET METHODS

end % <<<<<<<< END BASE CLASS
