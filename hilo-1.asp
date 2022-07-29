<!--
  FILE : hilo-1.asp
  PROJECT : assignment-WDD-A04
  PROGRAMMER : Yinruo Jiang
  FIRST VERSION : 2021-10-12
  SECOND VERSION : 2021-10-13
  DESCRIPTION : This source demonstrates the Hi-Lo game, which allow the user guess the number generated by program
-->
<!DOCTYPE html>
<html>
  <head>
    <title>Hi-Lo Game</title>
    <link rel="stylesheet" type="text/css" href="theHiLo/hilostyles.css">
  </head>
  <script type="text/javascript">
    //FUNCTION : function checkMaxNum()
    //DESCRIPTION : This function validate the user input of Maximum number of guessing range
    //PARAMETERS : None
    function checkMaxNum(maxNum) 
    {
      //reset the error message
      error.innerHTML = "";
      
      if ((maxNum.trim()).length == 0)
      {
        error.innerHTML = "Your maximum guess number <b>cannot</b> be BLANK.";
      } 
      else 
      {
        //check whether the input contain letter or space
        if (isNaN(maxNum.trim()) == true) 
        {
            error.innerHTML = "You <b>must</b> enter an integer which can not contain letter or space";
        }
        //check whether the input is the integer or float
        else if (Number.isInteger(Number(maxNum.trim())) == false)
        {
          error.innerHTML = "You <b>must</b> enter an integer not a float or double";
        }
        else 
        //validation pass, reset error message and submit the form
        {
            numValid = true;
            error.innerHTML = "";
            document.maxNumForm.submit();  
        }
      }
    }

    //FUNCTION : function serverNumValid(fname,maxNum)
    //DESCRIPTION : This function validate the user input of Maximum number of guessing range
    //PARAMETERS : fname as string 
    //             maxNum as integer
    <%
    sub serverNumValid(fname,maxNum)
        //Check whether the maximum guessing number is greater than 0'
      If(maxNum<=0 and maxNum <>"") Then
        Response.Write("You <b>must</b> enter an integer greater than zero.")
      ElseIf  (maxNum > 0 and maxNum <>"") Then   
        //validation Pass rediect to the next asp and save the cookies 
        Response.Cookies("fname")=fname
        Response.Cookies("maxNum")=maxNum
        Response.Cookies("numToGuess")=numToGuess
        Response.Redirect "hilo-2.asp"
      End If
    end sub
    %>
  </script>
  <body>
    <%
      dim fname
      dim maxNum
      dim minNum

      fname =Request.Cookies("fname") 
      'Receive fname from form'  
      if(Request.Form("fname") <> "") Then
        fname=Request.Form("fname")
      End If
      'Receive maxNum from form' 
      maxNum= Request.Form("maxNum")
      
      minNum=1
      Randomize
      'Generate the random number'
      randomNum = Int((maxNum-minNum+1)*Rnd+minNum)
      numToGuess = randomNum
    %>

    <form action="hilo-1.asp" method="post" name="maxNumForm" >
      <p>Welcome <%=fname%>,
      <br><br>
      What is your maximum guess value? <input type="text" name="maxNum" value="" size="20" autofocus/>
      <input type="button" value="Submit" onclick="checkMaxNum(maxNum.value);" />
      <input type="hidden" name="fname" value="<%=fname%>" />
    </p>
    </form>
    <div id="error" style="color:red;">
      <%call serverNumValid(fname, maxNum)%>
    </div>
  </body>
</html>