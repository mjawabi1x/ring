# Project : 2048 Game
# Date    : 2018/08/29
# Author : Gal Zsolt (~ CalmoSoft ~)
# Email   : <calmosoft@gmail.com>

load "stdlib.ring"
load "guilib.ring"

size = 4
limit = 6
num = 0
flag = 0
button = newlist(size,size)
moveleft = []
moveright = []
moveup = []
movedown = []
myfilter2 = null

app = new qApp {
          StyleFusion()
          win = new qWidget() {
                  setWindowTitle('2048 Game')
                  move(490,100) 
                  for n = 1 to size
                       for m = 1 to size
                            button[n][m] = new MyButton(win)
                       next
                  next
                  arrow = new qLineedit(win)
                  mup = new qPushButton(win)
                  mdown = new qPushButton(win)
                  mleft = new qPushButton(win)
                  mright = new qPushButton(win)
                  newgame = new qPushButton(win)
                  myfilter = new qallevents(win)
                  myfilter.setResizeEvent("pResize()")
                  installeventfilter(myfilter)
                  pResize()
           show()
         }
    exec()
}

func pResize()
                  winwidth = win.width()
                  winheight = win.height()
                  arrow.close()
                  arrow = new qLineedit(win) {
                              setGeometry(0,7*floor(winheight/8),winwidth,floor(winheight/8))
                              arrow.setfocus(true)
                              myfilter2 = new qAllEvents(win) {
                              setkeypressevent("keypress()")
                  }
                  installeventfilter(myfilter2)
                  }
                  for n = 1 to size
                       for m = 1 to size
                            button[n][m].close()
                            col = (n-1)*floor(winwidth/4)
                            row = (m-1)*floor(winheight/8)
                            fontsize = 10 + (winheight/16)
                            button[n][m] = new MyButton(win) {
                                                   setGeometry(col,row,winwidth/4,winheight/8)
                                                   setFont(new qFont("Verdana",fontsize,100,0))
                                                   setalignment(Qt_AlignHCenter | Qt_AlignVCenter)
                                                   setstylesheet('background-color:orange')
                                                   show()
                                                   }
                           next
                  next
                  newgame.close()
                  newgame = new qPushButton(win) {
                                    setGeometry(0,7*floor(winheight/8),winwidth,floor(winheight/8))
                                    setstylesheet('background-color:violet')
                                    settext('New Game')
                                    setClickEvent('pbegin()')
                                    show()
                                    }
                  mup.close()
                  mup = new qPushButton(win) {
                             setGeometry(0,5*floor(winheight/8),winwidth/4,floor(winheight/8))
                             settext('up')
                             setClickEvent('pup()')
                             show()
                             }
                  mdown.close()
                  mdown = new qPushButton(win) {
                                 setGeometry(floor(winwidth/4),5*floor(winheight/8),winwidth/4,floor(winheight/8))
                                 settext('down')
                                 setClickEvent('pdown()')
                                 show()
                                 }
                  mleft.close()
                  mleft = new qPushButton(win) {
                              setGeometry(2*floor(winwidth/4),5*floor(winheight/8),winwidth/4,floor(winheight/8))
                              settext('left')
                              setClickEvent('pleft()')
                              show()
                              }
                  mright.close()
                  mright = new qPushButton(win) {
                                setGeometry(3*floor(winwidth/4),5*floor(winheight/8),winwidth/4,floor(winheight/8))
                                settext('right')
                                setClickEvent('pright()')
                                show()
                                }
                  win.show()
                  pbegin()

func keypress() 
        nKey = myfilter2.getkeycode() 
        switch nKey
                   on 16777234 pleft()
                   on 16777236 pright()
                   on 16777235 pup()
                   on 16777237 pdown()
        off

func pbegin()
       for n = 1 to size
            for m = 1 to size
                 button[n][m].setStylesheet('background-color: orange')
                 button[n][m].settext('')
            next
        next
        for n = 1 to limit
             rn = random(size - 1) + 1
             rm = random(size - 1) + 1
             button[rn][rm].settext('2')
         next
         arrow.setfocus(true)

func pdown()
        num = gameover()
        if num = size*size
           flag = 1
           msgBox('You lost!')
           pbegin()
        ok
        if flag = 0
           pmovedown()
           newnum()
        ok

func pup()
        num = gameover()
        if num = size*size
           flag = 1
           msgBox('You lost!')
           pbegin()
        ok
        if flag = 0
           pmoveup()
           newnum()
        ok

func pleft()
        num = gameover()
        if num = size*size
           flag = 1
           msgBox('You lost!')
           pbegin()
        ok
        if flag = 0
           pmoveleft()
           newnum()
        ok

func pright()
        num = gameover()
        if num = size*size
           flag = 1
           msgBox('You lost!')
           pbegin()
        ok
        if flag = 0
           pmoveright()
           newnum()
        ok

func pmoveleft()
       for n = 1 to size
            moveleft = []
            for m = 1 to size
                 button[m][n] {temp = text()}
                 if temp != ''
                    add(moveleft,temp)
                 ok
            next
            movetilesleft(n,moveleft)
       next

func movetilesleft(nr,moveleft)
       for p = 1 to len(moveleft) - 1
            temp1 = moveleft[p]
            temp2 = moveleft[p+1]
            temp = string(number(temp1) + number(temp2))
            if (temp1 = temp2) and (temp1 != '0') and (temp2 != '0') and (temp1 != '') and (temp2 != '')
               if temp != '0' and temp != ''
                  moveleft[p] = temp
                  del(moveleft,p+1)
               ok
            ok
       next
       for n = 1 to len(moveleft)
            button[n][nr].settext(moveleft[n])
       next
       for n = len(moveleft) + 1 to size 
            if n <= size
               button[n][nr].setStylesheet('background-color: orange')
               button[n][nr].settext('')
            ok
       next
       return

func pmoveright()
       for n = 1 to size
            moveright = []
            for m = size to 1 step -1
                 button[m][n] {temp = text()}
                 if temp != ''
                    add(moveright,temp)
                 ok
            next
            movetilesright(n,moveright)
        next
        return

func movetilesright(nr,moveright)
       flag = 0
       for p = len(moveright) to 2 step -1
            temp1 = moveright[p]
            temp2 = moveright[p-1]
             if (temp1 = temp2) and (temp1 != '0') and (temp2 != '0') and (temp1 != '') and (temp2 != '')
               temp = string(number(temp1) + number(temp2))
               if temp != '0' and temp != ''
                  flag = 1
                  moveright[p] = temp
                  del(moveright,p-1)
                  if moveright[p-1] = temp
                     p = p - 1
                  ok
               ok
            ok
       next
       for n = 1 to len(moveright)
            button[size-n+1][nr].settext(moveright[n])
       next
       for n = 1 to size - len(moveright)
            if n <= size
               button[n][nr].setStylesheet('background-color: orange')
               button[n][nr].settext('')
            ok
       next

func pmoveup()
       for n = 1 to size
            moveup = []
            for m = 1 to size
                 button[n][m] {temp = text()}
                 if temp != ''
                    add(moveup,temp)
                 ok
            next
            movetilesup(n,moveup)
        next
        return

func movetilesup(nr,moveup)
        flag = 0
        for p = 1 to len(moveup) - 1
             temp1 = moveup[p] 
             temp2 = moveup[p+1]
             if (temp1 = temp2) and (temp1 != '0') and (temp2 != '0') and (temp1 != '') and (temp2 != '')
               temp = string(number(temp1) + number(temp2))
               if temp != '0' and temp != ''
                  flag = 1
                  moveup[p] = temp
                  del(moveup,p+1)
               ok
            ok
       next
       for n = 1 to len(moveup)
            button[nr][n].settext(moveup[n])
       next
       for n = len(moveup) + 1 to size 
            if n <= size
               button[nr][n].setStylesheet('background-color: orange')
               button[nr][n].settext('')
            ok
       next

func pmovedown()
       for n = 1 to size
            movedown = []
            for m = size to 1 step -1
                 button[n][m] {temp = text()}
                 if temp != ''
                    add(movedown,temp)
                 ok
            next
            movetilesdown(n,movedown)
        next
        return

func movetilesdown(nr,movedown)
        flag = 0
        for p = 1 to len(movedown) - 1
             temp1 = movedown[p]
             temp2 = movedown[p+1]
             if (temp1 = temp2) and (temp1 != '0') and (temp2 != '0') and (temp1 != '') and (temp2 != '')
               temp = string(number(temp1) + number(temp2))
               if temp != '0' and temp != ''
                  flag = 1
                  movedown[p] = temp
                  del(movedown,p+1)
               ok
            ok
       next
       for n = 1 to len(movedown)
            button[nr][size-n+1].settext(movedown[n])
       next
       for n = size - len(movedown) to 1 step -1 
            if n <= size
               button[nr][n].setStylesheet('background-color: orange')
               button[nr][n].settext('')
            ok
       next

func newnum()
        nums = [2,4]
        while true
                rn = random(size - 1) + 1
                rm = random(size - 1) + 1
                ran = random(len(nums) - 1) + 1
                if button[rn][rm].text() = ''
                   button[rn][rm].settext(string(nums[ran]))
                   exit
                ok
        end
        return

func gameover()
        num = 0
        flag = 0
        for n = 1 to size
             for m = 1 to size 
                  if button[n][m].text() != ''
                     num = num + 1
                  ok
              next
        next
        return num

func msgBox(text) {
	m = new qMessageBox(win) {
	       setWindowTitle('2048 Game')
	       setText(text)
	       show()
	       }
        }

func showarray(vect)
        see "["
        svect = ""
        for n = 1 to len(vect)
              svect = svect + vect[n] + " "
        next
        svect = left(svect, len(svect) - 1)
        see svect
        see "]" + nl

class MyButton from qLabel
       func setText cValue 
              Super.setText(cValue)
              switch cValue 
                        on '2' setStyleSheet('foreground-color:blue; background-color: yellow')
                        on '4' setStylesheet('foreground-color:white; background-color: violet')
                        on '8' setStylesheet('foreground-color:white; background-color: blue')
                        on '16' setStylesheet('foreground-color:black; background-color: green')
                        on '32' setStylesheet('foreground-color:white; background-color: red')
                        on '64' setStylesheet('foreground-color:white; background-color: gray')
                        on '128' setStylesheet('foreground-color:violet; background-color: white')
              off
