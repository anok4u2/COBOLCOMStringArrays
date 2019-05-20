      $set ooctrl(+p)
       identification division.
       program-id. pokus444.

       special-names.
           environment-name  is environment-name
           environment-value is environment-value
           decimal-point is comma.

       class-control.
mftech     CharacterArray     is class "chararry"
mftech     OLESafeArray       is class "olesafea"
           ChkAccNum is class "$OLE$CheckAccountNumber.AccountNumbers".

       working-storage section.
mftech copy mfole.
mftech copy olesafea.
       01  ChkAccNumObj                 object reference.
       01  accA.
           05  acc                      pic x(34) occurs 100.
       01  accR                         pic x(34).
mftech 01  ws-stringArray               object reference.
mftech 01  ws-vartype                   pic 9(4) comp-5.
mftech 01  ws-dimension                 pic 9(4) comp-5.
mftech 01  ws-saBound                   SAFEARRAYBOUND occurs 2.
mftech 01  ws-iIndex                    pic 9(9) comp-5.
mftech 01  ws-iIndex2d                  pic 9(9) comp-5 occurs 2.
mftech 01  ws-len                       pic 9(9) comp-5.
mftech 01  ws-hresult                   pic 9(9) comp-5.
mftech 01  ws-2d-element.
mftech     03  filler                   pic x(8) value "Element ".
mftech     03  ws-sub1                  pic 9.
mftech     03  filler                   pic x(3) value " : ".
mftech     03  ws-sub2                  pic 9.
       procedure division.
       main section.
           display "Zacatek programu"

           initialize accA accR
           move '1234567890' to acc(1)
           move '0987654321' to acc(2)

      ***** Create a 1 Dimension OLESAFEARRAY to pass string array
           move VT-BSTR to ws-vartype
           move 1       to ws-dimension
           move 2 to cElements of ws-saBound(1) 
           move 0 to llBound of ws-saBound(1)
           invoke OLESafeArray "new" using by value ws-vartype
                                                    ws-dimension
                                           by reference ws-saBound(1)
               returning ws-stringArray
           end-invoke

      ***** Populate 2 Elements in OLESAFEARRAY
           move 0  to ws-iIndex
           move 10 to ws-len
           invoke ws-stringArray "putString"
                   using by reference ws-iIndex
                         by value     ws-len
                         by reference acc(1)
               returning ws-hresult
           end-invoke
           if ws-hresult not = 0
               display "Die Gracefully"
               stop run
           end-if
           move 1 to ws-iIndex
           move 10 to ws-len
           invoke ws-stringArray "putString"
                   using by reference ws-iIndex
                         by value ws-len
                         by reference acc(2)
               returning ws-hresult
           end-invoke
           if ws-hresult not = 0
               display "Die Gracefully"
               stop run
           end-if

           invoke ChkAccNum "new" returning ChkAccNumObj
      ***** Pass across the OLESAFEARRAY
           invoke ChkAccNumObj "CheckAccount" using ws-stringArray
                                          returning accR
           display accR

      ***** Finalize the OLESAFEARRAY 
           invoke ws-stringArray "finalize" returning ws-stringArray

      ***** We will now pass a 2D array into C#

      ***** Create a 1 Dimension OLESAFEARRAY to pass string array
           move VT-BSTR to ws-vartype
           move 2 to ws-dimension
           move 2 to cElements of ws-saBound(1)
           move 0 to llBound of ws-saBound(1)
           move 3 to cElements of ws-saBound(2)
           move 0 to llBound of ws-saBound(2)
           invoke OLESafeArray "new" using by value ws-vartype
                                                    ws-dimension
                                           by reference ws-saBound(1)
                                 returning ws-stringArray
           end-invoke
      ***** We have the Array now populate it.
      ***** 0 based array
           perform varying ws-sub1 from 0 by 1 until ws-sub1 > 1
               perform varying ws-sub2 from 0 by 1 until ws-sub2 > 2
      ***** Populate Element in OLESAFEARRAY
                   move ws-sub1 to ws-iIndex2d(1) 
                   move ws-sub2 to ws-iIndex2d(2) 
                   move length of ws-2d-element to ws-len
                   invoke ws-stringArray "putString"
                           using by reference ws-iIndex2d(1)
                                 by value     ws-len
                                 by reference ws-2d-element
                       returning ws-hresult
                   end-invoke
                   if ws-hresult not = 0
                       display "Die Gracefully"
                       stop run
                   end-if
               end-perform
           end-perform

      ***** Pass across the OLESAFEARRAY
           invoke ChkAccNumObj "CheckAccount2d" using ws-stringArray
                                          returning accR
           display accR

           stop run.

