/*
Language: Dart
Author: PhiLho (Philippe Lhoste) <PhiLho(a)GMX.net>
*/

function(hljs)
{
	var IDENTIFIER = /[a-zA-Z_$][a-zA-Z0-9_$]*/;
	var OPENING_BLOCK_COMMENT = '/\\*';
	var CLOSING_BLOCK_COMMENT = '\\*/';
	var BLOCK_COMMENT =
	{
		begin: OPENING_BLOCK_COMMENT, end: CLOSING_BLOCK_COMMENT,
		contains: ['self']
	};
	var INTERPOLATION =
	{
		className: 'interpolation',
		relevance: 10,
		variants:
		[
			{ begin: '\\$\\{', end: '\\}' },
			{ begin: '\\$(?!=\\w)', end: '\\w\\b' }
		]
	};
	return {
		lexemes: IDENTIFIER,
		keywords:
		{
			keyword:
				'assert break case catch class const continue default do else enum extends ' +
				'false final finally for if in is new null rethrow return super switch ' +
				'this throw true try var void while with',
			built_in:
				'abstract as dynamic export external factory get implements import library ' +
				'operator part set static typedef',
			type:
				'bool double int num String List Map Function'
		},
		contains:
		[
			{
				className: 'dartdoc',
				begin: '/\\*\\*', end: '\\*/',
				contains:
				[{
					className: 'dartdocref', begin: '(^|\\s)\\[\\w+\\]'
				}],
				relevance: 7
			},
			{
				className: 'dartdoc',
				begin: '///', end: '$',
				contains:
				[{
					className: 'dartdocref', begin: '(^|\\s)\\[\\w+\\]'
				}],
				relevance: 10
			},
			{
				className: 'string',
				relevance: 10,
				variants:
				[
					{ begin: 'r"', end: '"' },
					{ begin: "r'", end: "'" }
				]
			},
			{
				className: 'string',
				contains: [hljs.BACKSLASH_ESCAPE, INTERPOLATION],
				illegal: '\\n',
				relevance: 5,
				variants:
				[
					{ begin: '"', end: '"' },
					{ begin: "'", end: "'" }
				]
			},
			{
				className: 'string',
				contains: [hljs.BACKSLASH_ESCAPE, INTERPOLATION],
				relevance: 10,
				variants:
				[
					{ begin: '"""', end: '"""' },
					{ begin: "'''", end: "'''" }
				]
			},
			{
				className: 'class',
				beginKeywords: 'class interface', end: '{',
				excludeEnd: true,
				illegal: ':',
				contains:
				[
					{
						beginKeywords: 'extends implements with|10',
						relevance: 7
					},
					{
						className: 'title',
						begin: IDENTIFIER
					},
					hljs.C_LINE_COMMENT_MODE,
					hljs.C_BLOCK_COMMENT_MODE
				]
			},
			{
				className: 'annotation',
				begin: '@[A-Za-z]+',
				relevance: 7
			},
			hljs.C_LINE_COMMENT_MODE,
			{
				className: 'comment',
				begin: OPENING_BLOCK_COMMENT, end: CLOSING_BLOCK_COMMENT,
				contains: [BLOCK_COMMENT]
			},
			hljs.APOS_STRING_MODE,
			hljs.QUOTE_STRING_MODE,
			hljs.C_NUMBER_MODE
		]
	};
}


