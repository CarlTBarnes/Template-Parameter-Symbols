# Template Procedure Parameter Symbols C9

New Procedure Parameter Symbols were added in C9. The only place they are documented is on the Clarion Sharp blog page:

https://clarionsharp.com/blog/changes-to-template-built-in-symbols-in-c9/

The page has the most important symbol wrong saying "%ProcedureParameterName is Multi", it should say "%ProcedureParameters is Multi". All the parameter symbols are dependent on %ProcedureParameters.

## ParamSymbolC9Test.TPL

This repo includes this template that can be added to a procdure to show its prototype with all 8 symbols and their values. There is an Extension that generates into Date and a Code template that generates into the current embed. Example out below:

```clarion
!------------Extension: ParamSymbolsTestC9 from ParamSymbolsTestC9tpl ------------
!---------------------------------------------------------------------------------
! %Prototype:   (<CONST *BYTE[] P1>, BYTE P2_Def=2, <BYTE P3_Omt>, *BYTE P4_Addr, *LONG[] A1, *SHORT[,] A2, ? U1, *? U2)
! %Parameters:  (<CONST *BYTE[] P1>,BYTE P2_Def,<BYTE P3_Omt>,*BYTE P4_Addr,*LONG[] A1,*SHORT[,] A2,? U1,*? U2) 
!----------------------------------------------------------------------------------
! #FOR(%ProcedureParameters)  is MULTI dependent on %Procedure
!----------------------------------------------------------------------------------
! Parameter # 1 - BYTE P1 
! %ProcedureParameters           = P1                    ! Name also, was hoping was entire parameter
! %ProcedureParameterName        = P1                    ! Name from Parameters
! %ProcedureParameterOrigName    = P1                    ! Name from Protoype
! %ProcedureParameterType        = BYTE                  ! TYPE w/o CONST * [] decoration &  UPPER
! %ProcedureParameterDefault     =                       ! Value if TYPE NAME=Default Value
! %ProcedureParameterOmitted     = 1                     ! %True (1) if <omitted>
! %ProcedureParameterByReference = 1                     ! %True (1) if *TYPE (by Address), no * then %False 
! %ProcedureParameterConstant    = 1                     ! %True (1) if CONST
! %ProcedureParameterDIMs        = 1                     ! TYPE[] Array 1=[] 2=[,] 3=[,,] ... 0=Not[]
!----------------------------------------------------------------------------------
! Parameter # 2 - BYTE P2_Def 
! %ProcedureParameters           = P2_Def                ! Name also, was hoping was entire parameter
! %ProcedureParameterName        = P2_Def                ! Name from Parameters
! %ProcedureParameterOrigName    = P2_Def                ! Name from Protoype
! %ProcedureParameterType        = BYTE                  ! TYPE w/o CONST * [] decoration &  UPPER
! %ProcedureParameterDefault     = 2                     ! Value if TYPE NAME=Default Value
! %ProcedureParameterOmitted     =                       ! %True (1) if <omitted>
! %ProcedureParameterByReference =                       ! %True (1) if *TYPE (by Address), no * then %False 
! %ProcedureParameterConstant    =                       ! %True (1) if CONST
! %ProcedureParameterDIMs        = 0                     ! TYPE[] Array 1=[] 2=[,] 3=[,,] ... 0=Not[]
!----------------------------------------------------------------------------------
```

## Blog Post Revised Parameters

`%Parameters` - single, dependent from %Procedure
The full list of a procedure’s formal parameters separated by commas and enclosed in parentheses unless empty

`%ProcedureParameters` - multi, dependent from %Procedure
The list of names of all procedure parameters. Multi-valued symbol to `#FOR(%ProcedureParameters)`

#### Symbols: single, dependent from %ProcedureParameters

`%ProcedureParameterName` -
The list of names of all formal parameters as entered in %Parameters symbols; if missing then the name of that parameter as in %Prototype symbol is returned; if that is missing too, an AppGen generated name is returned

`%ProcedureParameterOrigName` -
The name of the parameter as entered in the %Prototype symbol

`%ProcedureParameterType` - 
The type of the parameter as entered in the %Prototype symbol (without the CONST keyword and square brackets for array types) in UPPER CASE.

`%ProcedureParameterDefault` - 
The default value of parameters as entered in the %Prototype symbol

`%ProcedureParameterOmitted` - 
Returns %True if the parameter is declared as <omittable> in the %Prototype symbol

`%ProcedureParameterByReference` - 
Returns %True if the parameter’s type is declared with leading * in the %Prototype symbol. For types only passed by address (like QUEUE) this will not be true unless prototyped as *QUEUE.

`%ProcedureParameterConstant` - 
Returns %True if the parameter’s type is declared with the CONST keyword in the %Prototype symbol

`%ProcedureParameterDIMs` - 
Returns the number of dimensions if the parameter’s type is declared as an array in the %Prototype symbol (1 for [] , 2 for [,] , etc.). Returns 0 if not [].


https://clarionsharp.com/blog/changes-to-template-built-in-symbols-in-c9/