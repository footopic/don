$(function() {
    var $title = $('#article_title');
    var $text_edit = $('#article_text');
    var $text_preview = $('#text-preview-area');
    var $submit_btn = $('#btn-submit');
    if (!$title.length || !$text_edit.length) {
        return;
    }
    var l = localStorage;

    if ($text_edit.val() != null) {
        $text_preview.html(marked($text_edit.val()));
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
        $text_preview.html(marked($(this).val()));
        l.setItem("text", $(this).val());
        // code hilighting
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
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
