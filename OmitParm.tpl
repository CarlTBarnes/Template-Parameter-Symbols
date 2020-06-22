#TEMPLATE(OmitParmEquates,'Omitted Parameter Equates') ,FAMILY('ABC','CW20')
#!------------------------------------------------------------------------------
#!  Omitted Parm List -
#!------------------------------------------------------------------------------
#EXTENSION(OmitParmOrdinalEquates,'Omitted Parameter List Equates for OMITTED()')
  #RESTRICT
    #IF (~%prototype OR SUB(%prototype,1,2)='()')
      #REJECT
    #ELSE
      #ACCEPT
    #ENDIF
  #ENDRESTRICT
#DISPLAY('Defines Equates of the type OMIT:Variable')
#DISPLAY('for all omittable variables in the Parameters list.')
#DISPLAY('')
#DISPLAY('OmitParm     ITEMIZE')
#DISPLAY('NotOmit:Var1    EQUATE')
#DISPLAY('Omit:Var2       EQUATE')
#DISPLAY('Omit:Var3       EQUATE')
#DISPLAY('             END')
#DISPLAY('')
#DISPLAY('Usage: IF OMITTED(Omit:Variable)')
#DISPLAY('')
#DISPLAY('OmitParm Template was written by Carl Barnes in March 2000.')
#DISPLAY('Written for ClarionMag ITEMIZE Your Parameters For A Better OMITTED().')
#DISPLAY('')
#!---
#AT(%DataSection),WHERE(%parameters AND SUB(%parameters,1,2)<>'()' )
OmitParm     ITEMIZE    !%Prototype
    #EQUATE(%PrototypeLeft, SUB(LEFT(%Prototype),2,255))       #!Remove leading (
    #EQUATE(%ParametersLeft, SUB(LEFT(%Parameters),2,255))     #!Remove leading (
    #DECLARE(%NextProto)
    #DECLARE(%NextParam)
    #DECLARE(%OmitEquate)
    #! Take the Parameter and Prototype lists and parse them into pieces to make equates
    #LOOP
        #CALL(%OmitParmParseNext,%ParametersLeft),%NextParam
        #IF (~%NextParam)
            #BREAK
        #ENDIF
        #CALL(%ParseComplexParm,%NextParam)
        #CALL(%OmitParmParseNext,%PrototypeLeft),%NextProto
        #IF (INSTRING('>', %NextProto, 1))
            #SET(%OmitEquate,'Omit:' & %NextParam )
%[20]OmitEquate  EQUATE   !  IF OMITTED(%OmitEquate)
        #ELSE
            #SET(%OmitEquate,'NotOmit:' & %NextParam )
%[20]OmitEquate  EQUATE
        #END
    #ENDLOOP
   END
#ENDAT
#!--
#! Take %ParseThis, strip off the first parameter and return it, remove it from %ParseThis
#GROUP(%OmitParmParseNext, * %ParseThis)   #! Returns Next Param
    #DECLARE(%Idx,LONG)
    #DECLARE(%ArrayLevel,LONG)
    #EQUATE(%ReturnVar,'')
    #LOOP,FOR(%Idx,2, INSTRING(')',%ParseThis) )
        #CASE(SUB(%ParseThis,%Idx,1))
        #OF(',')
        #OROF(')')
            #IF(%ArrayLevel AND SUB(%ParseThis,%Idx,1)=',')
                #CYCLE
            #ENDIF
            #SET(%ReturnVar, LEFT(SUB(%ParseThis,1 ,%Idx-1 )) )
            #SET(%ParseThis, LEFT(SUB(%ParseThis,%Idx+1,255 )) )
            #BREAK
        #OF('[')
            #SET(%ArrayLevel, %ArrayLevel + 1)
        #OF(']')
            #SET(%ArrayLevel, %ArrayLevel - 1)
        #ENDCASE
    #ENDLOOP
    #RETURN(%ReturnVar)
#!--
#! Take value, strip off "<" and ">" if present, pick Last word if space present.
#! Parm line can be same as prototype <type label> or have <PARM> or in 5.5 <CONST TYPE LABEL> or LONG Name=0
#GROUP(%ParseComplexParm, * %FixThis)
    #DECLARE(%TestPos,LONG)
    #SET(%TestPos,(INSTRING('<<',%FixThis,1)))                   #! Change: <LONG XPos> to: LONG XPos>
    #IF(%TestPos)
      #SET(%FixThis,LEFT(SUB(%FixThis,%TestPos+1,255)))
    #ENDIF
    #SET(%TestPos,(INSTRING('>',%FixThis,1)))                    #! Change: LONG XPos> to: LONG XPos
    #IF(%TestPos)
      #SET(%FixThis,CLIP(LEFT(SUB(%FixThis,1,%TestPos - 1))))
    #ENDIF
    #SET(%TestPos,(INSTRING('=',%FixThis,1)))                    #! Change: LONG Xpos=1 to: LONG Xpos
    #IF(%TestPos)
      #SET(%FixThis,CLIP(LEFT(SUB(%FixThis,1,%TestPos - 1))))
    #ENDIF
    #LOOP                                                        #! Find Last Word e.g. CONST TYPE LABEL
        #SET(%TestPos,(INSTRING(' ',CLIP(%FixThis),1)))
        #IF(~%TestPos)
           #BREAK
        #ENDIF
        #SET(%FixThis,LEFT(SUB(%FixThis,%TestPos,255)))
    #ENDLOOP
    #SET(%FixThis,CLIP(%FixThis))
