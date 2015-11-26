$(function() {
    var $title = $('#article_title');
    var $text_edit = $('#article_text');
    var $text_preview = $('#text-preview-area');
    var $submit_btn = $('#btn-submit');
    if (!$title.length || !$text_edit.length) {
        return;
    }
    var l = localStorage;

    function updatePreview() {
        $text_preview.html(marked($text_edit.val()));
        // code hilighting
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
        // 絵文字
        emojify.run($text_preview[0]);
    }

    console.log($text_edit.val());
    console.log($text_edit.val() != null);
    if ($text_edit.val() != null) {
        updatePreview();
    }

    // // ローカルストレージに保存されていたら復元
    if ($text_edit.val() == "" && l.getItem("text") != null) {
        var text = l.getItem("text");
        $text_edit.val(text);
    }
    if ($title.val() == "" && $title.length && l.getItem("title") != null) {
        $title.val(l.getItem("title"));
    }

    // 変更をマークダウンにしプレビューに反映する
    $text_edit.keyup(function() {
        l.setItem("text", $(this).val());
        updatePreview();
    });
    $title.keyup(function() {
        l.setItem("title", $(this).val());
    });

    $submit_btn.click(function() {
        // TODO: validation check
        console.log("checked");
        l.removeItem("text");
        l.removeItem("title");
    });
});
