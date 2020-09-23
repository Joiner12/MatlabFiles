function ans_m = why_m(n)
%WHY    Provides succinct answers to almost any question.
%   WHY, by itself, provides a random answer.
%   WHY(N) provides the N-th answer.
%   Please embellish or modify this function to suit your own tastes.

%   Copyright 1984-2014 The MathWorks, Inc.

if nargin > 0
    dflt = rng(n,'v5uniform');
end
switch randi(10)
    case 1
        a = special_case;
    case {2, 3, 4}
        if false
            a = phrase;
        else
            a = special_case;
        end
    otherwise
        if false
            a = sentence;
        else
            a = special_case;
        end
end
if isstring(a)
    temp = '';
    for i=1:1:length(a)
        chatemp = convertStringsToChars(a(i));
        if ~isequal(chatemp,' ')
            temp = sprintf('%s %s',temp,chatemp);
        end
    end
    a = temp;
end
a(1) = upper(a(1));
ans_m = a;
% disp(a);
if nargin > 0
    rng(dflt);
end


% ------------------

function a = special_case
%{
   switch randi(12)
    case 1
        a = 'why not?';
    case 2
        a = 'don''t ask!';
    case 3
        a = 'it''s your karma.';
    case 4
        a = 'stupid question!';
    case 5
        a = 'how should I know?';
    case 6
        a = 'can you rephrase that?';
    case 7
        a = 'it should be obvious.';
    case 8
        a = 'the devil made me do it.';
    case 9
        a = 'the computer did it.';
    case 10
        a = 'the customer is always right.';
    case 11
        a = 'in the beginning, God created the heavens and the earth...';
    case 12
        a = 'don''t you have something better to do?';
end
%}
%
sfhd = ["为啥子不？","莫问!","it''s your karma'","愚蠢的问题!","我啷个晓得!","你懂我意思不嘛？",...
    "很明显了撒。","魔鬼驱动着我！","电脑干的。","顾客总是对的！","最开始，上帝创造了天空和大地...",...
    "你没得qiu事了吗？"];

a = sfhd(randi(12));
function a = phrase

switch randi(3)
    case 1
        a = ['for the ' nouned_verb ' ' prepositional_phrase '.'];
    case 2
        a = ['to ' present_verb ' ' object '.'];
    case 3
        a = ['because ' sentence];
end


function a = preposition
switch randi(2)
    case 1
        a = 'of';
    case 2
        a = 'from';
end

function a = prepositional_phrase
switch randi(3)
    case 1
        a = [preposition ' ' article ' ' noun_phrase];
    case 2
        a = [preposition ' ' proper_noun];
    case 3
        a = [preposition ' ' accusative_pronoun];
end

function a = sentence
a = [subject ' ' predicate '.'];

function a = subject
switch randi(4)
    case 1
        a = proper_noun;
    case 2
        a = nominative_pronoun;
    otherwise
        a = [article ' ' noun_phrase];
end

%{
   hanhan = [锂,钠,钾,铷,铯,钫,钾,钙,钪,钛,钒,铬,锰,铁,钴,镍,铜,锌,镓,锗];
%}
function a = proper_noun
if false
    switch randi(12)
        case 1
            a = 'Cleve';
        case 2
            a = 'Jack';
        case 3
            a = 'Bill';
        case 4
            a = 'Joe';
        case 5
            a = 'Pete';
        case 6
            a = 'Loren';
        case 7
            a = 'Damian';
        case 8
            a = 'Barney';
        case 9
            a = 'Nausheen';
        case 10
            a = 'Mary Ann';
        case 11
            a = 'Penny';
        case 12
            a = 'Mara';
    end
else
    hanhan = ['锂','钠','钾','铷','铯','钫','钾','钙','钪','钛','钒','铬','锰','铁','钴','镍','铜','锌','镓','锗'];
    a = strcat(hanhan(randi(12)),'憨憨');
end


function a = noun_phrase
switch randi(4)
    case 1
        a = noun;
    case 2
        a = [adjective_phrase ' ' noun_phrase];
    otherwise
        a = [adjective_phrase ' ' noun];
end

function a = noun
%{
       switch randi(6)
        case 1
            a = 'mathematician';
        case 2
            a = 'programmer';
        case 3
            a = 'system manager';
        case 4
            a = 'engineer';
        case 5
            a = 'hamster';
        case 6
            a = 'kid';
    end
%}
er = ["数xio老se","搬zuan的","网管儿","恭城si","锤zi","小chui子"];
a = er(randi(6));

function a = nominative_pronoun
%{
  switch randi(5)
        case 1
            a = 'I';
        case 2
            a = 'you';
        case 3
            a = 'he';
        case 4
            a = 'she';
        case 5
            a = 'they';
    end
%}
heshethey = ["我","你","他","她","他们"];
a = heshethey(randi(5));

function a = accusative_pronoun
%{
   switch randi(4)
        case 1
            a = 'me';
        case 2
            a = 'all';
        case 3
            a = 'her';
        case 4
            a = 'him';
    end
%}
heshethey = ["我","所有人","她","他"];
a = heshethey(randi(4));


function a = nouned_verb
if false
    switch randi(2)
        case 1
            a = 'love';
        case 2
            a = 'approval';
    end
else
    heshethey = ["爱","jio得ojbk"];
    a = heshethey(randi(2));
end

function a = adjective_phrase
switch randi(6)
    case {1 2 3}
        a = adjective;
    case {4 5}
        a = [adjective_phrase ' and ' adjective_phrase];
    case 6
        a = [adverb ' ' adjective];
end

function a = adverb
switch randi(3)
    case 1
        a = 'very';
    case 2
        a = 'not very';
    case 3
        a = 'not excessively';
end

function a = adjective
switch randi(7)
    case 1
        a = 'tall';
    case 2
        a = 'bald';
    case 3
        a = 'young';
    case 4
        a = 'smart';
    case 5
        a = 'rich';
    case 6
        a = 'terrified';
    case 7
        a = 'good';
end

function a = article
switch randi(3)
    case 1
        a = 'the';
    case 2
        a = 'some';
    case 3
        a = 'a';
end

function a = predicate
switch randi(3)
    case 1
        a = [transitive_verb ' ' object];
    otherwise
        a = intransitive_verb;
end

function a = present_verb
switch randi(3)
    case 1
        a = 'fool';
    case 2
        a = 'please';
    case 3
        a = 'satisfy';
end

function a = transitive_verb
switch randi(10)
    case 1
        a = 'threatened';
    case 2
        a = 'told';
    case 3
        a = 'asked';
    case 4
        a = 'helped';
    otherwise
        a = 'obeyed';
end

if false
    sdhf = ["威胁","告诉","要求","帮","遵从"];
    a = sdhf(randi(10));
end

function a = intransitive_verb

switch randi(6)
    case 1
        a = 'insisted on it';
    case 2
        a = 'suggested it';
    case 3
        a = 'told me to';
    case 4
        a = 'wanted it';
    case 5
        a = 'knew it was a good idea';
    case 6
        a = 'wanted it that way';
end


if false
    asd = ["坚持","建议","告诉我去","想要","晓得那是个好主意","想那样干"];
    a = asd(randi(6));
end

function a = object
switch randi(10)
    case 1
        a = accusative_pronoun;
    otherwise
        a = [article ' ' noun_phrase];
end
