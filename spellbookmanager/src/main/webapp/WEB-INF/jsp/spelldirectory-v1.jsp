<!DOCTYPE html>


<html lang="en">
<head>
    <link href="spellstyles.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="directory-wrapper">
    <div name="spell-directory-actions" class="spell-directory-actions">
        <h2><a th:href="@{/}">Spell Directory</a></h2>
        <h2><a th:href="@{/directory-2}">Spell Directory 2</a></h2>
        Sorting options<br>
        <div class="selector">
            <a th:href="@{/spellbook-directory}">Spellbook Management</a><br>
        </div>
        <div class="selector">
            <a th:href="@{/add-spell}" class="selector">Add another spell to the list</a><br>
        </div>
        <div style="border:solid black;">
            <strong>Search Options:</strong><br>
            <form th:action="@{/search}" th:object="${spellSearchParams}" method="post">
                <label th:for="name">Name:</label>
                <input type="text" id="name" name="name" th:field="*{spellName}"/><br>
                <label th:for="spellLevel">Spell Level: </label>
                <select name="spellLevel" id="spellLevel" th:field="*{spellLevel}">
                    <option th:value="N"></option>
                    <option th:each="val : ${#numbers.sequence(0,9)}" th:value="${val}" th:text="${val}"></option>
                </select><br>
                <label for="school">School:</label>
                <select name="school" id="school" th:field="*{school}">
                    <option value=""></option>
                    <option th:each="val : ${schoolList}" th:value="${val}" th:text="${val}"></option>
                </select><br>
                <label for="ritual">Only Ritual Casting?</label>
                <input type="checkbox" name="ritual" id="ritual" th:field="*{ritualCasting}"/>
                <label for="concentration">Only Concentration?</label>
                <input type="checkbox" name="concentration" id="concentration" th:field="*{concentration}"/><br>
                <input type="submit" value="Search!">
            </form>
        </div>
    </div>
    <div name="spell-list-display" class="spell-display-list">
        <table>
            <tr style="font-size: larger;">
                <th>Spell Name</th>
                <th>Lvl.</th>
                <th>School</th>
                <th></th>
                <th></th>
            </tr>
            <tr th:each="spell : ${spells}">
                <td th:class="${spell.school}">
                    <a th:href="@{/spell(spellname=${spell.name})}" class="directory-row-element">
                        <div th:text="${spell.name}">Spell Name</div>
                    </a>
                </td>
                <td th:class="${spell.school}">
                    <div th:text="${spell.spellLevel}">Lvl</div>
                </td>
                <td th:class="${spell.school}">
                    <div th:text="${spell.school}">School</div>
                </td>
                <td th:class="${spell.school}">
                    <a th:href="@{/edit-spell(spellname=${spell.name})}" class="directory-row-element">
                        <div>Edit...</div>
                    </a>
                </td>
                <td th:class="${spell.school}">
                    <a th:href="@{/delete-spell(spellname=${spell.name})}" class="directory-row-element">
                        <div>[X]</div>
                    </a>
                </td>
                <th:block th:if="${spellbook != null}">
                    <!--TODO: Properly implement check against spells already in spellbooks-->
                    <td th:class="${spell.school}">
                        <th:block th:if="${#lists.contains(spellbook.listOfSpells, spell)}">
                            <div>&#10004;</div>
                        </th:block>

                        <th:block th:unless="${#lists.contains(spellbook.listOfSpells, spell)}">
                            <a th:href="@{/add-to-spellbook(spellname=${spell.name},spellbookID=${spellbook.spellbookID})}"
                               class="directory-row-element" method="post">
                                <div> (+)</div>
                            </a>
                        </th:block>
                    </td>
                </th:block>
            </tr>


        </table>
    </div>
</div>
<br>
<br><br><br>

</body>
</html>

