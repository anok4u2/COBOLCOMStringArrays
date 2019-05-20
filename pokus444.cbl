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
mftech 01  ws-saBound                   SAFEARRAYBOUND occurs 1.
mftech 01  ws-iIndex                    pic 9(9) comp-5.
mftech 01  ws-len                       pic 9(9) comp-5.
mftech 01  ws-hresult                   pic 9(9) comp-5.

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
           stop run.

