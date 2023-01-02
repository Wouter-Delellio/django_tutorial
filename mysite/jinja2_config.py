from django.conf import settings
from django.contrib.staticfiles.storage import staticfiles_storage
from django.urls import reverse
from django.utils import translation, timezone
from django.utils.dateformat import format
from jinja2 import Environment

# from api.client import get_client


def jinja2_datetime(value):
    """Format a date time to (Default)"""
    if value is None:
        return ''
    return format(timezone.localtime(value), settings.DATETIME_FORMAT)


def jinja2_date(value):
    """Format a date to (Default)"""
    if value is None:
        return ''
    return format(value, settings.DATE_FORMAT)


def environment(**options):
    options['extensions'] = ['jinja2.ext.i18n',
                             'jinja2.ext.with_',
                             ]
    env = Environment(**options)
    env.install_gettext_translations(translation)
    env.globals.update({
        'static': staticfiles_storage.url,
        'url': reverse,
        'get_current_language': translation.get_language,
        'get_available_languages': settings.LANGUAGES,
        # 'lgcode': get_client().say_text,  # todo: should become a more performant solution
    })
    env.filters['datetime'] = jinja2_datetime
    env.filters['date'] = jinja2_date
    return env
