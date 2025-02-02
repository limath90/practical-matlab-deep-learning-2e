%% Script to create all the sentences and labels
% Reads the database and saves the Sentences mat-file. Takes a few seconds.
%% See also
% ReadDatabase, extractBefore, extractAfter, DistinctWords, MapToNumbers

[s,u,v,a] = ReadDatabase;

%   s {1040,1} Sentences
%   u (1040,2) Range of underlines in sentence
%   v {1040,5} Possible words including 4 imposters
%   a (1040,1) Which of the five words is correct


% Whatever you want in the training, ex. 100, length(s) for all.
nSentences = length(s);

i = 1;
c = zeros(size(v,2)*nSentences,1);
z = strings(size(v,2)*nSentences,1);
% Extract the parts of the sentences before and after the underlined part
% Then create sentences with all possible words
for k = 1:nSentences 
  q1    = extractBefore(s(k),u(k,1));
  q2    = extractAfter(s(k),u(k,2));
  for j = 1:size(v,2)
    z(i)  = q1 + v(k,j) + q2;
    if( j == a(k,1) )
      c(i) = 1;
    else
      c(i) = 0;
    end
    i = i + 1;
  end
end

%% Create a numeric dictionary
r = z(1);
for k = 2:length(z)
  r = r + " " + z(k); % append all the sentences to one string
end

d = DistinctWords( r ); % find the distinct words

nZ = cell(length(z),1);
for k = 1:length(z)
  nZ{k} = MapToNumbers( z(k), d );
end

% Print 2 sentences
for k = 1:10
  fprintf('Category: %d',c(k));
  fprintf('%5d',nZ{k})
  fprintf('\n')
  if( mod(k,5) == 0 )
    fprintf('\n')
  end
end

%% Save the numbers and category in a mat-file
save('Sentences','nZ', 'c');


%% Copyright
% Copyright (c) 2019, 2022 Princeton Satellite Systems, Inc.
% All rights reserved.
