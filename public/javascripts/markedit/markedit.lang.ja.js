//
//  MarkEdit langauge: Japanese
//  MarkEdit 日本語
//
//  Note:  These translations were created with Google translator.
//  I'm sure they sound really awkwards.  If a native speaker would
//  be interested in polishing it up, it would be a great benefit.
//

MarkEditLanguage = function() {

    return {

        'defaultButtons': {
            'bold': {
                'tip': '\u3088\u308a\u5f37\u8abf'
            },
            'italic': {
                'tip': '\u5f37\u8abf'
            },
            'link': {
                'tip': '\u30ea\u30f3\u30af'
            },
            'image': {
                'tip': '\u753b\u50cf'
            },
            'code': {
                'tip': '\u30b3\u30fc\u30c9\uff08\u8907\u6570\u884c\u9078\u629e\u53ef\uff09'
            },
            'quote': {
                'tip': '\u5f15\u7528\uff08\u8907\u6570\u884c\u9078\u629e\u53ef\uff09'
            },
            'numberlist': {
                'tip': '\u756a\u53f7\u4ed8\u304d\u30ea\u30b9\u30c8'
            },
            'bulletlist': {
                'tip': '\u756a\u53f7\u7121\u3057\u30ea\u30b9\u30c8'
            },
            'line': {
                'tip': '\u6c34\u5e73\u7dda'
            },
            'heading': {
                'tip': '\u898b\u51fa\u3057'
            },
            'undo': {
                'tip': '\u5143\u306b\u623b\u3059'
            },
            'redo': {
                'tip': '\u3084\u308a\u76f4\u3057'
            },
            'edit': {
                'text': '\u7de8\u96c6',
                'tip': '\u7de8\u96c6\u3059\u308b'
            },
            'preview': {
                'text': '\u30d7\u30ec\u30d3\u30e5\u30fc',
                'tip': '\u30d7\u30ec\u30d3\u30e5\u30fc\u3059\u308b'
            }
        },

        'dialog': {
            'insertLink': {
                'title': '\u30ea\u30f3\u30af',
                'helpText': 'URL\u3092\u5165\u529b\u3057\u3066\u4e0b\u3055\u3044',
                'insertButton': 'OK',
                'cancelButton': 'Cancel'
            },
            'insertImage': {
                'title':'\u753b\u50cf',
                'helpText': '\u753b\u50cf\u306eURL\u3092\u5165\u529b\u3057\u3066\u4e0b\u3055\u3044',
                'insertButton': 'OK',
                'cancelButton': 'Cancel'
            }
        },

        'errors' : {
            'markeditNotTextarea':'MarkEdit tag must be a <textarea>',
            'cannotLocateTextarea':'<textarea> tag could not be located in order to fetch the markeditGetState.'
        }

    };

}();