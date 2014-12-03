function [multiSimulationLCC] = multiSimuLCCpli(Opts)
N = 19;
  for i = 1: size(Opts,1)
      [multiSimulationLCC(i)]= SimuLCCpli(Opts(i,1:i));
  end    
end