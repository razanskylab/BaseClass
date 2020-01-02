% [out] = Show_Size_Info(FSP) @ FSP
% name says it all really...
%
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function Handle_Parallel_Workers(BC)
  if BC.runInParallel
    pool = gcp('nocreate'); % If no pool, do not create new one.
    if isempty(pool) && BC.nWorkers % make pool, specify nWorkers
      parpool(BC.nWorkers);
    elseif isempty(pool) && ~BC.nWorkers % make pool, default nWorkers
      pool = parpool();
      BC.nWorkers = pool.NumWorkers;
    elseif ~isempty(pool) && BC.nWorkers % pool already exists,
      % make sure it uses the number of workes we want
      if BC.nWorkers ~= pool.NumWorkers
        short_warn('Found pool but with wrong number of workers...recreating it.');
        delete(gcp('nocreate'));
        parpool(BC.nWorkers);
      end
    elseif ~isempty(pool) && ~BC.nWorkers % pool already exists,
      % make sure it uses the number of workes we want
      BC.nWorkers = pool.NumWorkers;
    end
  else
    delete(gcp('nocreate'));
  end
end

% example parfor loop:
% parfor (i = 1:nTasks,BC.nWorkers)
%
% end
