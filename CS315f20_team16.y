%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token AND
%token OR
%token ELSE
%token NOT
%token LP
%token RP
%token LB
%token RB
%token LSB
%token RSB
%token SL_COMMENT_SIGN
%token NEWLINE
%token COMMA
%token END_STMT
%token IF
%token VAR
%token DO
%token WHILE
%token FOR
%token RETURN
%token BOOLEAN
%token INTEGER
%token STRING
%token IDENTIFIER
%token EQUIVALENCE_CHECK
%token NOT_EQUAL_CHECK
%token LT
%token GT
%token LTE
%token GTE
%token ADD_SIGN
%token SUB_SIGN
%token MULT_SIGN
%token DIV_SIGN
%token MOD_SIGN
%token ADD_ASSIGNMENT
%token SUB_ASSIGNMENT
%token MULT_ASSIGNMENT
%token DIV_ASSIGNMENT
%token DEGREE
%token DOT
%token DOUBLE
%token ELSE_IF
%token TRUE
%token FALSE
%token CHAR
%token END_STMT
%token UNDERSCORE
%token IN_FUNC
%token OUT_FUNC
%token BEGIN_FUNC
%token INT_TYPE
%token CHAR_TYPE
%token BOOLEAN_TYPE
%token STRING_TYPE
%token DOUBLE_TYPE
%token VOID
%token GETINCLINATION
%token GETALTIMETER
%token GETTHERMOMETER
%token GETACCELEROMETER
%token SETCAMERA
%token GETTIMER
%token GETHOST
%token GETPORT

%start program
%right ASSIGNMENTOP
%%

//Program
program:
	begin
	;

begin:
	BEGIN_FUNC
	|BEGIN_FUNC statements
	;

statements:
	statement
	|statements statement
	;

statement:
	comment
	|type_declarations
	|conditional_stmt
	|loops
	|input_output_exp
	|int_addition_exp
	|function_calls
	|operational_assignmet_exp
	|primitive_function_call
	|primitive_function_declaration
	;

comment:
	SL_COMMENT_SIGN sentence SL_COMMENT_SIGN
	;

sentence:
	IDENTIFIER sentence
	|IDENTIFIER
	;

type_declarations:
	int_declaration
	|char_declaration
	|double_declaration
	|string_declaration
	|boolean_declaration
	|int_initialization
	|char_initialization
	|double_initialization
	|string_initialization
	|boolean_initialization
	|int_declaration_initialization
	|char_declaration_initialization
	|double_declaration_initialization
	|string_declaration_initialization
	|boolean_declaration_initialization
	;

boolean_exp:
	TRUE
	| FALSE
	| logical_exp
	;

logical_exp:
	INTEGER LT INTEGER
	|INTEGER GT INTEGER
	|INTEGER LTE INTEGER
	|INTEGER GTE INTEGER
	|INTEGER LT IDENTIFIER
	|INTEGER GT IDENTIFIER
	|INTEGER LTE IDENTIFIER
	|INTEGER GTE IDENTIFIER
	|IDENTIFIER LT INTEGER
	|IDENTIFIER GT INTEGER
	|IDENTIFIER LTE INTEGER
	|IDENTIFIER GTE INTEGER
	|IDENTIFIER LT IDENTIFIER
	|IDENTIFIER GT IDENTIFIER
	|IDENTIFIER LTE IDENTIFIER
	|IDENTIFIER GTE IDENTIFIER
	|IDENTIFIER AND IDENTIFIER
	|IDENTIFIER OR IDENTIFIER
	|BOOLEAN AND BOOLEAN
	|BOOLEAN OR BOOLEAN
	|BOOLEAN EQUIVALENCE_CHECK BOOLEAN
	|BOOLEAN NOT_EQUAL_CHECK BOOLEAN
	|IDENTIFIER EQUIVALENCE_CHECK IDENTIFIER
	|IDENTIFIER NOT_EQUAL_CHECK IDENTIFIER
	|IDENTIFIER EQUIVALENCE_CHECK BOOLEAN
	|IDENTIFIER NOT_EQUAL_CHECK BOOLEAN
	|IDENTIFIER EQUIVALENCE_CHECK INTEGER
	|IDENTIFIER NOT_EQUAL_CHECK INTEGER
	|IDENTIFIER EQUIVALENCE_CHECK DOUBLE
	|IDENTIFIER NOT_EQUAL_CHECK DOUBLE
	;

int_declaration:
    INT_TYPE IDENTIFIER END_STMT
char_declaration:
    CHAR_TYPE IDENTIFIER END_STMT
double_declaration:
    DOUBLE_TYPE IDENTIFIER END_STMT
string_declaration:
    STRING_TYPE IDENTIFIER END_STMT
boolean_declaration:
    BOOLEAN_TYPE IDENTIFIER END_STMT

int_initialization:
    IDENTIFIER ASSIGNMENTOP INTEGER END_STMT
	| IDENTIFIER ASSIGNMENTOP int_addition_exp END_STMT
	| IDENTIFIER ASSIGNMENTOP int_multiplication_exp END_STMT
	| IDENTIFIER ASSIGNMENTOP int_division_exp END_STMT
	| IDENTIFIER ASSIGNMENTOP int_subtraction_exp END_STMT
	| IDENTIFIER ASSIGNMENTOP int_mod_exp END_STMT
	;
boolean_initialization:
    IDENTIFIER ASSIGNMENTOP boolean_exp END_STMT
	;
char_initialization:
    IDENTIFIER ASSIGNMENTOP CHAR END_STMT
	;
double_initialization:
    IDENTIFIER ASSIGNMENTOP DOUBLE END_STMT
	|IDENTIFIER ASSIGNMENTOP double_addition_exp END_STMT
	|IDENTIFIER ASSIGNMENTOP double_division_exp END_STMT
	|IDENTIFIER ASSIGNMENTOP double_subtraction_exp END_STMT
	|IDENTIFIER ASSIGNMENTOP double_multiplication_exp END_STMT
	|IDENTIFIER ASSIGNMENTOP total_arithmetic_exp END_STMT
	;
string_initialization:
    IDENTIFIER ASSIGNMENTOP STRING END_STMT
	|IDENTIFIER ASSIGNMENTOP function_call
	;

int_declaration_initialization:
    INT_TYPE IDENTIFIER ASSIGNMENTOP INTEGER END_STMT
    |INT_TYPE IDENTIFIER ASSIGNMENTOP int_addition_exp END_STMT
    |INT_TYPE IDENTIFIER ASSIGNMENTOP int_multiplication_exp END_STMT
    |INT_TYPE IDENTIFIER ASSIGNMENTOP int_division_exp END_STMT
    |INT_TYPE IDENTIFIER ASSIGNMENTOP int_subtraction_exp END_STMT
    |INT_TYPE IDENTIFIER ASSIGNMENTOP int_mod_exp END_STMT
	|INT_TYPE IDENTIFIER ASSIGNMENTOP total_arithmetic_exp END_STMT
	|INT_TYPE IDENTIFIER ASSIGNMENTOP function_call
char_declaration_initialization:
    CHAR_TYPE IDENTIFIER ASSIGNMENTOP CHAR END_STMT
    |CHAR_TYPE IDENTIFIER ASSIGNMENTOP function_call
double_declaration_initialization:
    DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP DOUBLE END_STMT
    |DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP double_addition_exp END_STMT
    |DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP double_division_exp END_STMT
    |DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP double_subtraction_exp END_STMT
    |DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP double_multiplication_exp END_STMT
	|DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP total_arithmetic_exp END_STMT
	|DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP function_call
string_declaration_initialization:
    STRING_TYPE IDENTIFIER ASSIGNMENTOP STRING END_STMT
    |STRING_TYPE IDENTIFIER ASSIGNMENTOP function_call
boolean_declaration_initialization:
    BOOLEAN_TYPE IDENTIFIER ASSIGNMENTOP boolean_exp END_STMT
    |BOOLEAN_TYPE IDENTIFIER ASSIGNMENTOP function_call



conditional_stmt:
	if_stmt
	;

if_stmt:
	IF LP logical_exp RP LB statements RB
	| if_stmt else_stmt
	| if_stmt else_if_stmt
	| if_stmt else_if_stmt else_stmt
	;

else_if_stmt:
	ELSE_IF LP logical_exp RP LB statements RB

else_stmt:
	ELSE LB statements RB

loops:
	for_stmt
	| while_stmt
	| do_while
	;


for_stmt:
	FOR LP type_declarations logical_exp END_STMT operational_assignmet_exp RP LB statements RB
	;

for_exp:
	logical_exp
	|logical_exp for_exp
	|

while_stmt:
	WHILE LP logical_exp RP LB statements RB
	;

do_while:
	DO LB statements RB WHILE LP logical_exp RP END_STMT
	;

input_output_exp:
	int_input_stmt
	|double_input_stmt
	|char_input_stmt
	|boolean_input_stmt
	|string_input_stmt
	|total_input_stmt
	|string_output
	|int_output
	|char_output
	|boolean_output
	|double_output
	|total_output
	;

int_input_stmt:
    INT_TYPE IDENTIFIER ASSIGNMENTOP IN_FUNC LP RP END_STMT
	;
double_input_stmt:
    DOUBLE_TYPE IDENTIFIER ASSIGNMENTOP IN_FUNC LP RP END_STMT
	;
char_input_stmt:
    CHAR_TYPE IDENTIFIER ASSIGNMENTOP IN_FUNC LP RP END_STMT
	;
boolean_input_stmt:
    BOOLEAN_TYPE IDENTIFIER ASSIGNMENTOP IN_FUNC LP RP END_STMT
	;
string_input_stmt:
    STRING_TYPE IDENTIFIER ASSIGNMENTOP IN_FUNC LP RP END_STMT
	;
total_input_stmt:
	IDENTIFIER ASSIGNMENTOP IN_FUNC LP RP END_STMT
	;




string_output:
    OUT_FUNC LP STRING RP END_STMT
	;
int_output:
    OUT_FUNC LP INTEGER RP END_STMT
	;
double_output:
    OUT_FUNC LP DOUBLE RP END_STMT
	;
char_output:
    OUT_FUNC LP CHAR RP END_STMT
	;
boolean_output:
    OUT_FUNC LP BOOLEAN RP END_STMT
	;
total_output:
	OUT_FUNC LP IDENTIFIER RP END_STMT
	;
function_call_output:
    OUT_FUNC LP function_call RP END_STMT
	;
primitive_function:
    OUT_FUNC LP primitive_function RP END_STMT
	;


arithmetic_exp:
	int_subtraction_exp
	| double_subtraction_exp
	| int_multiplication_exp
	| double_multiplication_exp
	| int_division_exp
	| double_division_exp
	| total_arithmetic_exp
	;

total_arithmetic_exp:
    IDENTIFIER ADD_SIGN IDENTIFIER
    |IDENTIFIER SUB_SIGN IDENTIFIER
    |IDENTIFIER DIV_SIGN IDENTIFIER
    |IDENTIFIER MULT_SIGN IDENTIFIER
    |IDENTIFIER MOD_SIGN IDENTIFIER
	;

int_addition_exp:
    INTEGER ADD_SIGN INTEGER
    | IDENTIFIER ADD_SIGN INTEGER
    | INTEGER ADD_SIGN IDENTIFIER
	;

double_addition_exp:
    DOUBLE ADD_SIGN DOUBLE
    | IDENTIFIER ADD_SIGN DOUBLE
    | DOUBLE ADD_SIGN IDENTIFIER
	;

int_subtraction_exp:
    INTEGER SUB_SIGN INTEGER
    | IDENTIFIER SUB_SIGN INTEGER
    | INTEGER SUB_SIGN IDENTIFIER
	;

double_subtraction_exp:
    DOUBLE SUB_SIGN DOUBLE
    | IDENTIFIER SUB_SIGN DOUBLE
    | DOUBLE SUB_SIGN IDENTIFIER
	;

int_multiplication_exp:
    INTEGER MULT_SIGN INTEGER
    | IDENTIFIER MULT_SIGN INTEGER
    | INTEGER MULT_SIGN IDENTIFIER
	;

double_multiplication_exp:
    DOUBLE MULT_SIGN DOUBLE
    | IDENTIFIER MULT_SIGN DOUBLE
    | DOUBLE MULT_SIGN IDENTIFIER
	;

int_division_exp:
    INTEGER DIV_SIGN INTEGER
    | IDENTIFIER DIV_SIGN INTEGER
    | INTEGER DIV_SIGN IDENTIFIER
	;

double_division_exp:
    DOUBLE DIV_SIGN DOUBLE
    | IDENTIFIER DIV_SIGN DOUBLE
    | DOUBLE DIV_SIGN IDENTIFIER
	;

int_mod_exp:
    INTEGER MOD_SIGN INTEGER
    |INTEGER MOD_SIGN IDENTIFIER
    |IDENTIFIER MOD_SIGN INTEGER
	;
	operational_assignmet_exp:
		int_add_assignment_exp
		|double_add_assignment_exp
		|int_sub_assignment_exp
		|double_sub_assignment_exp
		|int_mult_assignment_exp
		|double_mult_assignment_exp
		|int_div_assignment_exp
		|double_div_assignment_exp
;

int_add_assignment_exp:
	INT_TYPE IDENTIFIER ADD_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER ADD_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER ADD_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER ADD_ASSIGNMENT function_calls
	| INT_TYPE IDENTIFIER ADD_ASSIGNMENT primitive_function END_STMT
	| IDENTIFIER ADD_ASSIGNMENT function_calls
;
double_add_assignment_exp:
	DOUBLE_TYPE IDENTIFIER ADD_ASSIGNMENT DOUBLE END_STMT
	| DOUBLE_TYPE IDENTIFIER ADD_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER ADD_ASSIGNMENT DOUBLE END_STMT
	| IDENTIFIER ADD_ASSIGNMENT IDENTIFIER END_STMT
	| DOUBLE_TYPE IDENTIFIER ADD_ASSIGNMENT function_calls
	| DOUBLE_TYPE IDENTIFIER ADD_ASSIGNMENT primitive_function END_STMT
	| IDENTIFIER ADD_ASSIGNMENT primitive_function END_STMT
;
int_sub_assignment_exp:
	INT_TYPE IDENTIFIER SUB_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER SUB_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER SUB_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER SUB_ASSIGNMENT function_calls
	| INT_TYPE IDENTIFIER SUB_ASSIGNMENT primitive_function END_STMT
;
double_sub_assignment_exp:
	DOUBLE_TYPE IDENTIFIER SUB_ASSIGNMENT DOUBLE END_STMT
	| DOUBLE_TYPE IDENTIFIER SUB_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER SUB_ASSIGNMENT DOUBLE END_STMT
	| IDENTIFIER SUB_ASSIGNMENT IDENTIFIER END_STMT
	| DOUBLE_TYPE IDENTIFIER SUB_ASSIGNMENT function_calls
	| DOUBLE_TYPE IDENTIFIER SUB_ASSIGNMENT primitive_function END_STMT
	| IDENTIFIER SUB_ASSIGNMENT function_calls
	| IDENTIFIER SUB_ASSIGNMENT primitive_function END_STMT
;
int_mult_assignment_exp:
	INT_TYPE IDENTIFIER MULT_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER MULT_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER MULT_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER MULT_ASSIGNMENT function_calls
	| INT_TYPE IDENTIFIER MULT_ASSIGNMENT primitive_function END_STMT
;
double_mult_assignment_exp:
	DOUBLE_TYPE IDENTIFIER MULT_ASSIGNMENT DOUBLE END_STMT
	| DOUBLE_TYPE IDENTIFIER MULT_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER MULT_ASSIGNMENT DOUBLE END_STMT
	| IDENTIFIER MULT_ASSIGNMENT IDENTIFIER END_STMT
	| DOUBLE_TYPE IDENTIFIER MULT_ASSIGNMENT function_calls
	| DOUBLE_TYPE IDENTIFIER MULT_ASSIGNMENT primitive_function END_STMT
	| IDENTIFIER MULT_ASSIGNMENT function_calls
	| IDENTIFIER MULT_ASSIGNMENT primitive_function END_STMT
;
int_div_assignment_exp:
	INT_TYPE IDENTIFIER DIV_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER DIV_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER DIV_ASSIGNMENT INTEGER END_STMT
	| INT_TYPE IDENTIFIER DIV_ASSIGNMENT function_calls
	| INT_TYPE IDENTIFIER DIV_ASSIGNMENT primitive_function END_STMT
;
double_div_assignment_exp:
	DOUBLE_TYPE IDENTIFIER DIV_ASSIGNMENT DOUBLE END_STMT
	| DOUBLE_TYPE IDENTIFIER DIV_ASSIGNMENT IDENTIFIER END_STMT
	| IDENTIFIER DIV_ASSIGNMENT DOUBLE END_STMT
	| IDENTIFIER DIV_ASSIGNMENT IDENTIFIER END_STMT
	| DOUBLE_TYPE IDENTIFIER DIV_ASSIGNMENT function_calls
	| DOUBLE_TYPE IDENTIFIER DIV_ASSIGNMENT primitive_function END_STMT
	| IDENTIFIER DIV_ASSIGNMENT function_calls
	| IDENTIFIER DIV_ASSIGNMENT primitive_function END_STMT
;

function_calls:
	return_stmt
	| parameter
	| returned_function
	| void_function
	| paraVoid_function
	| paraReturn_function
	| function_call
	;

types:
	INT_TYPE
	| CHAR_TYPE
	| DOUBLE_TYPE
	| STRING_TYPE
	| BOOLEAN_TYPE
	;

return_stmt:
    RETURN IDENTIFIER END_STMT
	;
return_int_stmt:
	RETURN INTEGER END_STMT
;
return_double_stmt:
	RETURN DOUBLE END_STMT
;
return_string_stmt:
	RETURN STRING END_STMT
;
return_char_stmt:
	RETURN CHAR END_STMT
return_boolean_stmt:
	RETURN boolean_exp END_STMT
;
parameter:
    types IDENTIFIER
    | types IDENTIFIER COMMA parameter
	;

function_call_parameter:
	IDENTIFIER
	| IDENTIFIER COMMA function_call_parameter
	;


returned_function:
    INT_TYPE IDENTIFIER LP RP LB statements return_stmt RB
		| DOUBLE_TYPE IDENTIFIER LP RP LB statements return_stmt RB
		| CHAR_TYPE IDENTIFIER LP RP LB statements return_stmt RB
		| STRING_TYPE IDENTIFIER LP RP LB statements return_stmt RB
		| BOOLEAN_TYPE IDENTIFIER LP RP LB statements return_stmt RB
		| INT_TYPE IDENTIFIER LP RP LB statements return_int_stmt RB
		| DOUBLE_TYPE IDENTIFIER LP RP LB statements return_double_stmt RB
		| CHAR_TYPE IDENTIFIER LP RP LB statements return_char_stmt RB
		| STRING_TYPE IDENTIFIER LP RP LB statements return_string_stmt RB
		| BOOLEAN_TYPE IDENTIFIER LP RP LB statements return_boolean_stmt RB
	;

void_function:
    VOID IDENTIFIER LP RP LB statements RB
	;

paraVoid_function:
    VOID IDENTIFIER LP parameter RP LB statements RB
	;

paraReturn_function:
    INT_TYPE IDENTIFIER LP parameter RP LB statements return_stmt RB
		|DOUBLE_TYPE IDENTIFIER LP parameter RP LB statements return_stmt RB
		|CHAR_TYPE IDENTIFIER LP parameter RP LB statements return_stmt RB
		|STRING_TYPE IDENTIFIER LP parameter RP LB statements return_stmt RB
		|BOOLEAN_TYPE IDENTIFIER LP parameter RP LB statements return_stmt RB
		|INT_TYPE IDENTIFIER LP parameter RP LB statements return_int_stmt RB
		|DOUBLE_TYPE IDENTIFIER LP parameter RP LB statements return_double_stmt RB
		|CHAR_TYPE IDENTIFIER LP parameter RP LB statements return_char_stmt RB
		|STRING_TYPE IDENTIFIER LP parameter RP LB statements return_string_stmt RB
		|BOOLEAN_TYPE IDENTIFIER LP parameter RP LB statements return_boolean_stmt RB
	;

function_call:
    IDENTIFIER LP RP END_STMT
    | IDENTIFIER LP function_call_parameter RP END_STMT
	;

primitive_function_call:
	GETINCLINATION LP RP END_STMT
	|GETALTIMETER LP RP END_STMT
	|GETTHERMOMETER LP RP END_STMT
	|GETACCELEROMETER LP RP END_STMT
	|SETCAMERA LP boolean_exp RP END_STMT
	|GETTIMER LP RP END_STMT
	|GETHOST LP RP END_STMT
	|GETPORT LP RP END_STMT
;

primitive_function_declaration:
	DOUBLE_TYPE GETINCLINATION LP RP LB statements return_stmt RB
	|DOUBLE_TYPE GETALTIMETER LP RP LB statements return_stmt RB
	|DOUBLE_TYPE GETTHERMOMETER LP RP LB statements return_stmt RB
	|DOUBLE_TYPE GETACCELEROMETER LP RP LB statements return_stmt RB
	|VOID SETCAMERA LP BOOLEAN_TYPE IDENTIFIER RP LB statements RB
	|INT_TYPE GETTIMER LP RP LB statements return_stmt RB
	|STRING_TYPE GETHOST LP RP LB statements return_stmt RB
	|STRING_TYPE GETPORT LP RP LB statements return_stmt RB

%%
void yyerror(char *s) {
	fprintf(stdout, "line %d: %s\n", yylineno,s);
}
int main(void){
 yyparse();
if(yynerrs < 1){
		printf("Parsing: SUCCESSFUL!\n");
	}
 return 0;
}
