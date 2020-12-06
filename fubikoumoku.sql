declare
v_fubikoumoku VARCHAR2(100) := '';
cursor CUR_FUBISINSEI IS
    SELECT sinsei_joho_uniqkey FROM sinsei WHERE sinsei_status = '1';
    rec_fubisinsei CUR_FUBISINSEI%ROWTYPE;
cursor CUR_FUBIKOUMOKU IS
    SELECT sinsei_joho_uniqkey, fubi_koumoku FROM fubi where sinsei_joho_uniqkey = rec_fubisinsei.sinsei_joho_uniqkey;
    rec_fubikoumoku CUR_FUBIKOUMOKU%ROWTYPE;
begin
    open CUR_FUBISINSEI;
        loop
            fetch CUR_FUBISINSEI into rec_fubisinsei;
            exit when CUR_FUBISINSEI%notfound;
            open CUR_FUBIKOUMOKU;
                v_fubikoumoku := '';
                loop
                    fetch CUR_FUBIKOUMOKU into rec_fubikoumoku;
                    exit when CUR_FUBIKOUMOKU%notfound;
                    if (rec_fubikoumoku.fubi_koumoku = '1') then
                        v_fubikoumoku := v_fubikoumoku || '不備項目1 ';
                    elsif (rec_fubikoumoku.fubi_koumoku = '2') then
                        v_fubikoumoku := v_fubikoumoku || '不備項目2 ';
                    elsif (rec_fubikoumoku.fubi_koumoku = '3') then
                        v_fubikoumoku := v_fubikoumoku || '不備項目3 ';
                    elsif (rec_fubikoumoku.fubi_koumoku = '4') then
                        v_fubikoumoku := v_fubikoumoku || '不備項目4 ';
                    end if;
                end loop;
            close CUR_FUBIKOUMOKU;
                dbms_output.put_line(rec_fubisinsei.sinsei_joho_uniqkey || ': ' || v_fubikoumoku);
        end loop;
    close CUR_FUBISINSEI;
end;
/
