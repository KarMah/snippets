# Regular Expressions
# .             any character except newline
# [ ]           any single character of set
# [^ ]          any single character NOT of set
# *             0 or more previous regular expression
# *?            0 or more previous regular expression (non-greedy)
# +             1 or more previous regular expression
# +?            1 or more previous regular expression (non-greedy)
# ?             0 or 1 previous regular expression
# ??
# |             alternation
# ( )           grouping regular expressions
# ^             beginning of a line or string
# $             end of a line or string
# {m,n}        at least m but most n previous regular expression
# {m,n}?       at least m but most n previous regular expression (non-greedy)
# \1-9          nth previous captured group
# \A            beginning of a string
# \b            backspace(0x08)(inside[]only)
# \b            word boundary(outside[]only)
# \B            non-word boundary
# \d            digit, same as[0-9]
# \D            non-digit
# \S            non-whitespace character
# \s            whitespace character[ \t\n\r\f]
# \W            non-word character
# \w            word character[0-9A-Za-z_]
# \z            end of a string
# \Z            end of a string, or before newline at the end
# \/            forward slash

# [abc]	A single character of: a, b, or c
# [^abc]	Any single character except: a, b, or c
# [a-z]	Any single character in the range a-z
# [a-zA-Z]	Any single character in the range a-z or A-Z
# ^	Start of line
# $	End of line
# \A	Start of string
# \z	End of string
# .	Any single character
# \s	Any whitespace character
# \S	Any non-whitespace character
# \d	Any digit
# \D	Any non-digit
# \w	Any word character (letter, number, underscore)
# \W	Any non-word character
# \b	Any word boundary
# (...)	Capture everything enclosed
# (a|b)	a or b
# a?	Zero or one of a
# a*	Zero or more of a
# a+	One or more of a
# a{3}	Exactly 3 of a
# a{3,}	3 or more of a
# a{3,6}	Between 3 and 6 of a


# Given a Numeric, provide a String representation with commas inserted between each set of three digits in front of the decimal.
# For example, 1999995.99 should become "1,999,995.99".
quiz = 1000000000.24324
quiz.to_s.reverse.gsub(/(^\d*.?)?(\d{3})\B/, '\&,').reverse
quiz.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse


# ?: question-mark-colon is used to indicate that we want to capture a group, but not to count it for back reference
pattern = /(?:\d+)-(\d+)-\1/
match = pattern.match 'bird-cat-12-654-654-otter'
match.to_a.each { |e| p e }
# => "12-654-654"
# => "654"
# => "done"

# ? Greedy vs Non Greedy
str = 'Test greedy vs non-greedy'
greedy = /[a-z]* [a-z]*/
non_greedy = /[a-z]*? [a-z]*?/
p greedy.match(str)[0]     # => "est greedy"
p non_greedy.match(str)[0] # => "est "


# Case Sensitivity
# Case sensitive by default
match = /match/
'this is a match'.match(match)
'this is not a Match'.match(match)

# Ignore case sensitivity
match = /match/i
'this is a match'.match(match)
'this is a Match too'.match(match)

# ?i ?-i Dynamic
match = /ma(?i)t(?-i)ch/
'this is a match'.match(match)
'this is a maTch too'.match(match)
'this is not a matCh'.match(match)

# ?i: For substring
match = /this is (?i:substring) match/
'this is substring match'.match(match)
'this is subStRiNg match'.match(match)
'this is subStTiNg maTch'.match(match)


# ?= Zero width POSITIVE lookahead assertion
string = 'Who’s the more foolish?  The fool or the fool who follows him?'
string.gsub(/fool(?=ish)/, 'self')
# => "Who’s the more selfish?  The fool or the fool who follows him?"

# ?! zero-width NEGATIVE lookahead assertion
string = 'Who’s the more foolish?  The fool or the fool who follows him?'
string.gsub(/fool(?!ish)/, 'self')
# => "Who’s the more foolish?  The self or the self who follows him?"

# ?<= zero-width positive LOOKBEHIND assertion
string = 'For my ally is the force, and a powerful ally it is'
string.gsub(/(?<=powerful )ally/, "friend")
# => For my ally is the force, and a powerful friend it is.

# ?!= zero-width negative LOOKBEHIND assertion
string = 'For my ally is the force, and a powerful ally it is'
string.gsub(/(?<!powerful )ally/, "friend")
# => "For my friend is the force, and a powerful ally it is."


# https://www.blueboxcloud.com/insight/blog-article/using-regular-expressions-in-ruby-part-3-of-3
# Greedy vs Lazy vs Possessive

# Greedy
string = 'There’s no time to talk about time we don’t have the time'
/.+time/.match(string)
# => "There’s no time to talk about time we don’t have the time"

# Lazy
string = 'There’s no time to talk about time we don’t have the time'
/.+?time/.match(string)
# => "There’s no time"

# Possessive
string = 'There’s no time to talk about time we don’t have the time'
/.++time/.match(string)
# => nil

# Email Address
/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.\b/i.match('a_1.B+c-d%e@a1.B-d.com')
# ([A-Z]{2,4} | ([A-Z]{2}\.[A-Z]{2}))?

# Solution to HackerRank Problem https://www.hackerrank.com/challenges/detect-html-links
n = gets.strip.to_i
matcher = /<(a)\b\.* (?:href=\")?([^\"]+)\"(?:[^>]+>?|>)(?:(?:[\s]*<[^>]+>)+|)\s*([^<]*)/
n.times do 
  str = gets.strip.to_s
  str.scan(matcher).each do |res|
    a, link, text = res
    puts "#{link},#{text}" if link && text
  end
end
