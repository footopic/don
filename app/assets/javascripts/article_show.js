$(function () {
    var $text_preview = $('#text-preview');
    var $text_raw = $('#text-raw');

    if ($text_raw.length > 0 && $text_preview.length > 0) {
        $text_preview.html(marked($text_raw.html()));
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
        emojify.run($text_preview[0]);
    }
});
