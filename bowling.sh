
function readname
{ 
    trap "printf '\nYou cant escape with ctrl + c\n' " INT 
    while ((1))
    do
        echo "Enter the name with out space"
        read pname
        if echo "$pname" | grep '[0-9]' > /dev/null/null
        then
            clear
            echo "Invalid name, Number/s are not allowed in Name "
            echo "re - enter the to continue"
            continue
        fi
        if [[ -z $pname ]]
        then
            clear
            echo "The name never be  be empty"
            echo "re - enter the to continue"
            continue
        fi
        if grep "^$pname " bowlers.txt > /dev/null
        then
            echo "You are already a member"
        else
            echo "Welcome new Member"
        fi
        echo "You are $pname , enter anykey  to continue or N to re enter"
        read ch
        if [[ "$ch" = [Nn] ]]
        then
            continue
        else 
            break
        fi

    done
    return
}
function readfball
{
    typeset max=10
    while ((1))
    do
        read fball
        if [[ "$fball" = [Xx]  ]]
        then
            fball=max
            return $max
        elif [[ -z $fball ]]
        then
            echo "Score not entered please re enter the score"
            continue
        elif echo $fball | grep '[^0-9]' > /dev/null
        then 
            echo "invalid entry only numbers[1-10] or [Xx] "
            continue
        elif (( fball <= 10 && fball >= 0 ))
        then 
            return $fball
        else
          echo "invalid entry only numbers[1-10] or [Xx] "
        fi
    done
}

function readsball
{
    let "s=$1"
    while((1))
    do
        read sball
        if [[ "$sball" = '/'  ]]
        then     
            return $s
        elif [[ -z $sball ]]
        then
            echo "Score not entered please re enter the score"
            continue
        elif echo $sball | grep '[^0-9]' > /dev/null
        then 
            echo "invalid entry only number [1-$s]  or / "
            continue
        elif (( sball <= s))
        then
            return $sball
        else
          echo "invalid entry only number [1-$s]  or / "
        fi
    done
}

function disp
{   
    printf "_________________________________________________________________________\n"
    printf "|  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |  F7  |  F8  |  F9  |   F10  |\n"
    printf "%s\n" "-------------------------------------------------------------------------"
    k=1
    
    printf "|"

    while((k<11 && k<num))
    do
        if ((k==10))
        then
            ((k1=k+1))
            ((k2=k+2))
            if ((fball[k]==10))
            then
                if ((fball[k1]==10))
                then
                    if ((fball[k2]==10))
                    then
                        printf " X| X| X|"
                    else
                        printf " X| X| %d|" ${fball[k2]}
                    fi
                elif ((fball[k2]==10))
                then
                    printf " X| %d| X|" ${fball[k1]}
                else
                    printf " X| %d| %d|" ${fball[k1]} ${fball[k2]}
                fi
            elif ((((fball[k]+sball[k]))==10))
            then
                if ((fball[k1]==10))
                then
                    printf " %d| /| X|" ${fball[k]}
                else
                    printf " %d| /| %d|" ${fball[k]} ${fball[k1]}
                fi
            else
                    printf " %d| %d|  |" ${fball[k]} ${sball[k]}
                
            fi

        elif ((fball[k]==10))
        then
            printf "  | X |"
        else
            
            ((y=fball[k]+sball[k]))
            if ((y==10))
            then
                printf " %d| / |" ${fball[k]}
            else
                printf " %d| %d |" ${fball[k]} ${sball[k]}
            fi
        fi
        ((k=k+1))   
    done
        printf "\n%s\n" "-------------------------------------------------------------------------"

    if((num>11))
    then
        ((mnum = 11))
    else
        ((mnum = num))
    fi
    while (( i < mnum ))
    do
        ((i1=i+1))
        ((i2=i+2))
        if (( fball[i]==10 ))
        then 
           if ((num>i1))
           then
                if ((fball[i1]==10))
                then
                    if ((num>i2))
                    then
                        ((total[i]=20+fball[i2]))
                    else 
                        break
                    fi
                else 
                    #for 10th ball checking if tenth ball extra fram of next first ball will added
                    if((i==10))
                    then
                        ((total[i]=10+fball[i1]+fball[i2]))
                    else
                        ((total[i]=10+fball[i1]+sball[i1]))
                    fi
                fi
            else
                break
            fi
        
        else
            ((total[i]=fball[i]+sball[i]))
            if ((total[i]==10))
            then
                if ((num>i1))
                then
                ((total[i]=fball[i]+sball[i]+fball[i1]))
                else
                    break
                fi
            fi   
        fi
        ((i=i+1)) 
    done

    j=1
    printf "|"
    while((j<i))
    do
        if((j==10))
        then
            printf "  %3d   |" ${total[j]}
        else
            printf " %3d  |" ${total[j]}
        fi
        ((j=j+1))
    done
    printf "\n%s\n" "-------------------------------------------------------------------------"
    sum=0
    j=1
    printf "|"
    while (( j < i))
    do
        ((sum=sum+total[j]))
        if((j==10))
        then
            printf "  %3d   |" $sum
        else
            printf " %3d  |" $sum
        fi
        ((j=j+1))
    done
    printf "\n_________________________________________________________________________\n"
}

function turkey
{
    if((flag==3))
            then
                banner "Turkey "
                flag=0    
            fi
}

function gameon
{
    clear
    num=1
    i=1
    flag=0
    stcount=0
    pg=0
    spcount=0
    while (( num < 10))
    do
        
        turkey
        disp
        echo "Frame $num"
        echo "Enter the first ball score"
        readfball
        fball[num]=$?
        if ((fball[num] == 10))
        then
            ((flag=flag+1))
            clear
            banner strike
            ((stcount=stcount+1))
            ((num=num+1))
            continue
        
        elif ((fball[num]==0))
        then
            banner "gutter ball"
        fi
        
        flag=0
        ((rem=10-fball[num]))
        echo "Enter the 2nd ball score"
        readsball rem
        sball[num]=$?
        ((t=fball[num]+sball[num]))
        if ((t==10))
        then
            clear
            banner spare
            ((spcount=spcount+1))
            ((num=num+1))
            continue

        fi
        ((num=num+1))
        clear     
    done
    turkey
    disp
    echo "Frame $num"
    echo "Enter the first ball score"
    readfball
    fball[num]=$?
     if ((fball[num] == 10))
     then
        ((flag=flag+1))
        turkey
        ((stcount=stcount+1))
        ((num=num+1))
        banner strike
        echo "Enter the extra frame ball"
        readfball
        fball[num]=$?
        if ((fball[num] == 10))
        then
            banner strike
            ((flag=flag+1))
            turkey
            ((stcount=stcount+1))
        fi
        ((num=num+1))
        echo "Enter the extra frame  ball"
        readfball
        fball[num]=$?
        if ((fball[num] == 10))
        then
            banner strike
            ((flag=flag+1))
            turkey
            ((stcount=stcount+1))
        fi
    else
       ((rem=10-fball[num]))
       echo "Enter the 2nd ball score"
       readsball rem
       sball[num]=$?
       ((t=fball[num]+sball[num]))
       if ((t==10))
       then
            banner spare
            ((spcount=spcount+1))
            ((num=num+1))
            echo "Enter the extra frame  ball"
            readfball
            fball[num]=$?
            if ((fball[num] == 10))
            then
                banner strike
                ((stcount=stcount+1))
            fi
        fi
    fi
    ((num=num+1))
    clear
    echo "Final Score"
    disp
    echo "Saving the score in file"
    if((stcount==12))
    then
        ((pg=1))
    fi
    datet=$(date)
    printf "%s %s " $pname $datet >> bowlers.txt
    m=1
    while((m<11))
    do
        
        if ((fball[m]==10))
        then
            printf "|X,%d" ${total[m]} >> bowlers.txt
        elif ((((fball[m]+sball[m]))==10))
        then
            printf "%d|/,%d" ${fball[m]} ${total[m]} >> bowlers.txt
        else
            printf "%d|%d,%d" ${fball[m]} ${sball[m]} ${total[m]} >> bowlers.txt
        fi
        ((m=m+1))   
        printf " " >> bowlers.txt
    done
    printf "%d" $sum >> bowlers.txt
    printf "\n" >>bowlers.txt
    if grep "^$pname " stats.txt > /dev/null
    then
        nawk -v name="$pname" -v st="$stcount" -v sp="$spcount" -v sum="$sum" -v pg="$pg" '{if($1==name){ $2=$2+st; $3=$3+sp; $4=$3+$2; $5=$5+sum; $6=$6+1; $7=$5/$6; $8=$8+pg}}{print}' stats.txt >> stats2.txt
        rm stats.txt
        mv stats2.txt stats.txt
    else
        ((marks=stcount+spcount))
        printf "%s %d %d %d %d 1 %d %d\n" $pname $stcount $spcount $marks $sum $sum $pg >> stats.txt
    fi
    echo "Saving into file done"
    printf "\nHere your total stats\n"
    echo "=============================="
    printf "Total number of games played all the time: "
    nawk -v name="$pname" '{if($1==name){printf"%d\n" ,$6 }}' stats.txt
    printf "Total number of games strike you made: "
    nawk -v name="$pname" '{if($1==name){printf"%d\n" ,$2 }}' stats.txt
    printf "Total number of games spares you made: "
    nawk -v name="$pname" '{if($1==name){printf"%d\n" ,$3 }}' stats.txt
    printf "Total score sum all the time: "
    nawk -v name="$pname" '{if($1==name){printf"%d\n" ,$5 }}' stats.txt
    printf "Total average till now: "
    nawk -v name="$pname" '{if($1==name){printf"%d\n" ,$7 }}' stats.txt
    printf "Total number of perfect games: "
    nawk -v name="$pname" '{if($1==name){printf"%d\n\n" ,$8 }}' stats.txt

}
function showstats
{
    clear
    printf "\nTop 10 most striks all the time\n"
    printf "===============================\n"
    cat stats.txt | sort -r -nk2 | head | nawk '{printf"%s\t%d\n",$1,$2}'
    printf "\nTop 10 most marks all the time\n"
    printf "===============================\n"
    cat stats.txt | sort -r -nk4 | head | nawk '{printf"%s\t%d\n",$1,$4}'
    printf "\nTop 10 highest average all the time\n "
    printf "====================================\n"
    cat stats.txt | sort -r -nk7 | head | nawk '{printf"%s\t%6.3f\n",$1,$7}'
    printf "\nBelow is the List of people who got perfect game\n"
    printf "===================================================\n"
    cat stats.txt | nawk '{if($8>0){printf "%s\n",$1}}'
    printf "\npress any key to continue\n"
    read
}

###code from starts here 
clear
echo "Welcome"
#cheking the data files present or not 
if [[ ! -a "bowlers.txt" ]]
then
    touch bowlers.txt
fi
if [[ ! -a "stats.txt" ]]
then
    touch stats.txt
fi
while [ 1 ]
do
    select choice in enterName BeginTheGame  SeeTopStatistics Exit
    do
        clear
        case "$choice" in 
            enterName) readname
                        clear
                        break
                        ;;
            BeginTheGame) 
                            if [[ -z $pname ]]
                            then
                                echo "Before starting you need to enter the name"
                                break
                            fi
                            gameon
                            break
                            ;;
            SeeTopStatistics) showstats
                            clear
                            break
                            ;;
            Exit) exit 0
                    ;;
            *) echo "invalid choice"
                break
            ;;
        esac
    done 
done
trap INT
