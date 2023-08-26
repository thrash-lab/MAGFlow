{
read; read; read;
while IFS="" read -r p || [ -n "$p" ] ; do
    values=($p)
    if [[ $p = \ * ]] 
    then
        if (( $(echo "${values[12]} > 80.00" | bc -l)))
        then
            echo ${values[0]};
        fi
    fi
done
} < /project/thrash_89/db/EAGER_metaG_for_ck/pipeline_assemblies/CJ_V3_S9_assembly/20percent_par/checkm/dastools/output_table.txt
