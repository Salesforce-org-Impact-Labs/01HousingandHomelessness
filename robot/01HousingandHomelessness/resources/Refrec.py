
# import calendar
# import datetime
# import logging
# import pytz
# import time
# import warnings

# from BaseObjects import BaseRefrecPage
# from cumulusci.robotframework.utils import selenium_retry, capture_screenshot_on_error
# from robot.libraries.BuiltIn import RobotNotRunningError
# from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException
# from selenium.webdriver.common.keys import Keys
# from locators_51 import refrec_lex_locators as locators_51
# from locators_50 import refrec_lex_locators as locators_50

# locators_by_api_version = {
#     51.0: locators_51,  # Spring '21
#     50.0: locators_50   # Winter '21
# }

# # from locators_51 import refrec_lex_locators
# from cumulusci.robotframework import locator_manager

# # will get populated in _init_locators
# refrec_lex_locators = {}


# @selenium_retry
# class RefRec(object):

#     ROBOT_LIBRARY_SCOPE = "GLOBAL"
#     ROBOT_LIBRARY_VERSION = 1.0

#     def __init__(self, debug=False):
#         self.debug = debug
#         self.current_page = None
#         self._session_records = []
#         # Turn off info logging of all http requests
#         logging.getLogger("requests.packages.urllib3.connectionpool").setLevel(
#             logging.WARN
#         )

#         locator_manager.register_locators("refrec", refrec_lex_locators)