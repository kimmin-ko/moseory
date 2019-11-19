<tr>
    <th>배송지 선택</th>
    <td>
        <input type="radio" id="member-address" name="select-addr" value="member" checked="checked" />회원 정보와 동일
        &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" id="new-address" name="select-addr" value="new" />새로운 배송지
    </td>
</tr>
<tr>
    <th>받으시는분 <img src="/images/ico_required.gif"></th>
    <td><input type="text" name="name" /></td>
</tr>
<tr>
    <th>주소<img src="/images/ico_required.gif"></th>
    <td>
        <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" style="width: 100px; margin-bottom: 5px;">
        <input type="button" onclick="openZipSearch()" value="우편번호 찾기"><br>
        <input type="text" id="address1" name="address1" placeholder="주소" style="width: 196px; margin-bottom: 5px;"><br>
        <input type="text" id="address2" name="address1" placeholder="상세주소">
        <input type="text" id="extraAddress" placeholder="참고항목">
    </td>
</tr>
<tr>
    <th>일반전화</th>
    <td><select name="tel1" style="width: 70px; height: 23px;">
            <option>02</option>
            <option>031</option>
            <option>032</option>
            <option>033</option>
            <option>041</option>
            <option>042</option>
            <option>043</option>
            <option>044</option>
    </select> - <input type="text" name="tel2" style="width: 100px;" /> - 
    <input type="text" name="tel3" style="width: 100px;" /></td>
</tr>
<tr>
    <th>휴대전화 <img src="/images/ico_required.gif"></th>
    <td><select name="phone1" style="width: 70px; height: 23px;">
            <option>010</option>
            <option>011</option>
            <option>016</option>
            <option>017</option>
            <option>018</option>
            <option>019</option>
    </select> - <input type="text" name="phone2" style="width: 100px;" /> - <input
        type="text" name="phone3" style="width: 100px;" /></td>
</tr>
<tr>
    <th>이메일 <img src="/images/ico_required.gif"></th>
    <td><input type="text" name="email1" /> @ <input type="text"
        id="email" name="email2" /> <select id="select_email"
        style="height: 23px;" onchange="changeEmail()">
            <option value="">-- 이메일 선택 --</option>
            <option>naver.com</option>
            <option>daum.net</option>
            <option>nate.com</option>
            <option>gmail.com</option>
            <option>hotmail.com</option>
            <option>yahoo.com</option>
    </select></td>
</tr>
<tr>
    <th>배송메세지</th>
    <td><textarea name="delivery-message"
            style="width: 700px; height: 70px;"></textarea></td>
</tr>