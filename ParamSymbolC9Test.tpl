#TEMPLATE(ParamSymbolsTestC9tpl,'Parameter Symbols new in C9 Tester - #Extension and #Code') ,FAMILY('ABC','CW20')
#!------------------------------------------------------------------------------
#! Template by Carl Barnes free to use under MIT License.
#!------------------------------------------------------------------------------
#! New C9 symbols: https://clarionsharp.com/blog/changes-to-template-built-in-symbols-in-c9/
#! But this is wrong:  %ProcedureParameterName - multi,  dependent from %Procedure
#! The correct symbol: %ProcedureParameters      that is multi and %ProcedureParameterName is dependent
#! To find this I looked at the strings inside ClaGEN.dll that contained "parameter"
#!================================================================================
#EXTENSION(ParamSymbolsTestC9,'Parameter Symbols Added to C9 Test and Explore'),PROCEDURE
#DISPLAY('This template generates into the Data Section embed comments')
#INSERT(%DisplaysGroup)
#!-------
#AT(%DataSection),FIRST
!------------Extension: ParamSymbolsTestC9 from ParamSymbolsTestC9tpl ------------
#INSERT(%ParmsGenerate),NOINDENT 
#ENDAT
#!================================================================================
#CODE(ParamSymbolsCodeTestC9,'Parameter Symbols Added to C9 Test Code Template'),ROUTINE
#DISPLAY('This template generates into the current embed point comments')
#INSERT(%DisplaysGroup)
#!-------
!-------------Code: ParamSymbolsCodeTestC9 from ParamSymbolsTestC9tpl ------------
#INSERT(%ParmsGenerate),NOINDENT 
#!================================================================================
#GROUP(%DisplaysGroup)
#DISPLAY('with all 8 new symbols showing: ! %ProcedureParameter* = Value ') 
#DISPLAY('for this procedure prototype to show how the new symbols work.')
#DISPLAY('')
#DISPLAY('ClarionSharp Blog post noted new Parameter symbols were added in C9.') 
#DISPLAY('https://ClarionSharp.com/blog/changes-to-template-built-in-symbols-in-c9')
#DISPLAY('')
#DISPLAY('It was WRONG about the Multi Symbol that makes it all work.')
#DISPLAY('%%ProcedureParameterName should have been %%ProcedureParameters')
#DISPLAY('')
#DISPLAY('Template written by Carl Barnes.')
#DISPLAY('')
#GROUP(%ParmsGenerate)
    #DECLARE(%ParmNo,LONG)
!==================================================================================
! Read: https://clarionsharp.com/blog/changes-to-template-built-in-symbols-in-c9/
! Note: Webpage is WRONG saying  "%%ProcedureParameterName is Multi"  <--- Wrong
!                    should say  "%%ProcedureParameters    is Multi"  <--- Right
!----------------------------------------------------------------------------------
! %%Prototype:   %Prototype
! %%Parameters:  %Parameters 
    #IF (%ProcedureReturnType)
! %%ProcedureReturnType:  %ProcedureReturnType
    #ENDIF   
!----------------------------------------------------------------------------------
! #FOR(%%ProcedureParameters)  is MULTI dependent on %%Procedure
#FOR(%ProcedureParameters)
!----------------------------------------------------------------------------------
    #SET(%ParmNo,%ParmNo+1)
! Parameter # %ParmNo - %ProcedureParameterType %ProcedureParameterName 
! %%ProcedureParameters           = %[20]ProcedureParameters  ! Name also, was hoping for more
! %%ProcedureParameterName        = %[20]ProcedureParameterName  ! Name from Parameters
! %%ProcedureParameterOrigName    = %[20]ProcedureParameterOrigName  ! Name from Protoype
! %%ProcedureParameterType        = %[20]ProcedureParameterType  ! TYPE w/o CONST * [] decoration &  UPPER
! %%ProcedureParameterDefault     = %[20]ProcedureParameterDefault  ! Value if TYPE NAME=Default Value
! %%ProcedureParameterOmitted     = %[20]ProcedureParameterOmitted  ! %%True (1) if <omitted>
! %%ProcedureParameterByReference = %[20]ProcedureParameterByReference  ! %%True (1) if *TYPE (by Address), no * then %%False 
! %%ProcedureParameterConstant    = %[20]ProcedureParameterConstant  ! %%True (1) if CONST
! %%ProcedureParameterDIMs        = %[20]ProcedureParameterDIMs  ! TYPE[] Array 1=[] 2=[,] 3=[,,] ... 0=Not[]
#ENDFOR
!----------------------------------------------------------------------------------
! #ENDFOR  (%%ProcedureParameters)  
!==================================================================================
#!-----------------------