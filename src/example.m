% - Some examples of using kdbml library

% - setup some helper functions
k = qopen('localhost', 5555);  % your kdb server should be run on localhost on port 5555
Q = @(q) qdbc(k, q);

% - now we are ready to send queries to KDB -

% - lets create table with million records and put it to t variable
Q('t: `time xasc ([] time:09:30:00.0+1000000?23000000; sym:1000000?`AAPL`GOOG`IBM; bid:50+(floor (1000000?0.99)*100)%100; ask:51+(floor (1000000?0.99)*100)%100);')

% - now we can load data into Matlab and measure used time
% - result will be a structure in t variable
tic
t = Q('t');
toc
% on my computer (Intel i5, 16G RAM) it takes less then 0.6 sec

% - do something with the data
plot(t.time, (t.ask-t.bid)./(t.ask+t.bid));
datetick('x','HH:MM:SS')

% - note that kdbml transfers date/time to matlab date/time presentation
d = Q('2011.08.11 + til 10')
datestr(d)

% - kdb symbols converted to Matlab strings
s1 = Q('`SomeSymbol')
disp(class(s1))

% - kdb symbol list converted to Matlab cell array
s10 = Q('10?`aaa`bbb`ccc')
disp(class(s10))

% - it also provides transparent access to kdb dictionaries
dic = Q('`a`b`c!1 2 3')
disp(dic.a)