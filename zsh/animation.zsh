clear

logo=(
"       ,'''''"
"      |   ,.  |"
"      |  |  '_ |"
"  ,....|  |.."
".'  ,_;|    ..'"
"|  |   |  |"
"|  ',_,'  |"
" '.     ,'"
"   '''''"
)

for frame in 1 2 3 4 5 6 7 8; do
    clear

    i=0
    for line in "${logo[@]}"; do
        shift=$(( (8 - frame) * 2 ))

        if (( i % 2 == 0 )); then
            printf '%*s\033[36m%s\033[0m\n' "$shift" "" "$line"
        else
            printf '%*s\033[34m%s\033[0m\n' "$((shift + 4))" "" "$line"
        fi

        ((i++))
    done

    sleep 0.03
done

clear

fastfetch

printf '\033[36m██████████████████\033[34m██████████████████\033[35m██████████████████\033[32m██████████████████\033[33m██████████████████\033[0m\n'
