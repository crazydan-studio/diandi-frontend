{-
   点滴(DianDi) - 聚沙成塔，集腋成裘
   Copyright (C) 2022 by Crazydan Studio (https://studio.crazydan.org/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}


module Widget.MdcFontIcon exposing (..)


{-|

https://fonts.google.com/icons?icon.style=Outlined

```js
String.prototype.toCamelCase = function() {
    return this.replace(/^([A-Z])|[\s-_](\w)/g, function(match, p1, p2, offset) {
        if (p2) return p2.toUpperCase();
        return p1.toLowerCase();
    });
};
var icons = {};
var elmCode = '';
document.querySelectorAll('icons-group .icon-asset')
    .forEach(function(el) {
        var icon = (el.innerText);
        if (icons[icon]) {
            return;
        } else {
            icons[icon] = true;
        }

        var name = icon.toCamelCase().replace(/^(\d)/g, 'i$1');
        elmCode += `${name}: String\n${name} =\n    "${icon}"\n\n\n`;
    });
console.log(elmCode);
```

-}


search: String
search =
    "search"


home: String
home =
    "home"


menu: String
menu =
    "menu"


close: String
close =
    "close"


settings: String
settings =
    "settings"


done: String
done =
    "done"


expandMore: String
expandMore =
    "expand_more"


checkCircle: String
checkCircle =
    "check_circle"


favorite: String
favorite =
    "favorite"


add: String
add =
    "add"


delete: String
delete =
    "delete"


arrowBack: String
arrowBack =
    "arrow_back"


star: String
star =
    "star"


chevronRight: String
chevronRight =
    "chevron_right"


logout: String
logout =
    "logout"


arrowForwardIos: String
arrowForwardIos =
    "arrow_forward_ios"


addCircle: String
addCircle =
    "add_circle"


cancel: String
cancel =
    "cancel"


arrowBackIos: String
arrowBackIos =
    "arrow_back_ios"


arrowForward: String
arrowForward =
    "arrow_forward"


arrowDropDown: String
arrowDropDown =
    "arrow_drop_down"


moreVert: String
moreVert =
    "more_vert"


check: String
check =
    "check"


checkBox: String
checkBox =
    "check_box"


toggleOn: String
toggleOn =
    "toggle_on"


grade: String
grade =
    "grade"


openInNew: String
openInNew =
    "open_in_new"


checkBoxOutlineBlank: String
checkBoxOutlineBlank =
    "check_box_outline_blank"


refresh: String
refresh =
    "refresh"


login: String
login =
    "login"


chevronLeft: String
chevronLeft =
    "chevron_left"


expandLess: String
expandLess =
    "expand_less"


radioButtonUnchecked: String
radioButtonUnchecked =
    "radio_button_unchecked"


moreHoriz: String
moreHoriz =
    "more_horiz"


apps: String
apps =
    "apps"


arrowRightAlt: String
arrowRightAlt =
    "arrow_right_alt"


radioButtonChecked: String
radioButtonChecked =
    "radio_button_checked"


download: String
download =
    "download"


remove: String
remove =
    "remove"


toggleOff: String
toggleOff =
    "toggle_off"


bolt: String
bolt =
    "bolt"


arrowUpward: String
arrowUpward =
    "arrow_upward"


filterList: String
filterList =
    "filter_list"


deleteForever: String
deleteForever =
    "delete_forever"


autorenew: String
autorenew =
    "autorenew"


key: String
key =
    "key"


arrowDownward: String
arrowDownward =
    "arrow_downward"


sort: String
sort =
    "sort"


sync: String
sync =
    "sync"


addBox: String
addBox =
    "add_box"


block: String
block =
    "block"


arrowBackIosNew: String
arrowBackIosNew =
    "arrow_back_ios_new"


restartAlt: String
restartAlt =
    "restart_alt"


menuOpen: String
menuOpen =
    "menu_open"


shoppingCartCheckout: String
shoppingCartCheckout =
    "shopping_cart_checkout"


expandCircleDown: String
expandCircleDown =
    "expand_circle_down"


backspace: String
backspace =
    "backspace"


arrowCircleRight: String
arrowCircleRight =
    "arrow_circle_right"


undo: String
undo =
    "undo"


doneAll: String
doneAll =
    "done_all"


arrowRight: String
arrowRight =
    "arrow_right"


doNotDisturbOn: String
doNotDisturbOn =
    "do_not_disturb_on"


openInFull: String
openInFull =
    "open_in_full"


doubleArrow: String
doubleArrow =
    "double_arrow"


manageSearch: String
manageSearch =
    "manage_search"


syncAlt: String
syncAlt =
    "sync_alt"


zoomIn: String
zoomIn =
    "zoom_in"


doneOutline: String
doneOutline =
    "done_outline"


dragIndicator: String
dragIndicator =
    "drag_indicator"


fullscreen: String
fullscreen =
    "fullscreen"


keyboardDoubleArrowRight: String
keyboardDoubleArrowRight =
    "keyboard_double_arrow_right"


starHalf: String
starHalf =
    "star_half"


settingsAccessibility: String
settingsAccessibility =
    "settings_accessibility"


iosShare: String
iosShare =
    "ios_share"


arrowDropUp: String
arrowDropUp =
    "arrow_drop_up"


reply: String
reply =
    "reply"


exitToApp: String
exitToApp =
    "exit_to_app"


unfoldMore: String
unfoldMore =
    "unfold_more"


libraryAdd: String
libraryAdd =
    "library_add"


cached: String
cached =
    "cached"


selectCheckBox: String
selectCheckBox =
    "select_check_box"


terminal: String
terminal =
    "terminal"


changeCircle: String
changeCircle =
    "change_circle"


disabledByDefault: String
disabledByDefault =
    "disabled_by_default"


swapHoriz: String
swapHoriz =
    "swap_horiz"


swapVert: String
swapVert =
    "swap_vert"


appRegistration: String
appRegistration =
    "app_registration"


downloadForOffline: String
downloadForOffline =
    "download_for_offline"


closeFullscreen: String
closeFullscreen =
    "close_fullscreen"


arrowCircleLeft: String
arrowCircleLeft =
    "arrow_circle_left"


arrowCircleUp: String
arrowCircleUp =
    "arrow_circle_up"


fileOpen: String
fileOpen =
    "file_open"


minimize: String
minimize =
    "minimize"


openWith: String
openWith =
    "open_with"


keyboardDoubleArrowLeft: String
keyboardDoubleArrowLeft =
    "keyboard_double_arrow_left"


dataset: String
dataset =
    "dataset"


addTask: String
addTask =
    "add_task"


keyboardDoubleArrowDown: String
keyboardDoubleArrowDown =
    "keyboard_double_arrow_down"


start: String
start =
    "start"


keyboardVoice: String
keyboardVoice =
    "keyboard_voice"


createNewFolder: String
createNewFolder =
    "create_new_folder"


forward: String
forward =
    "forward"


downloading: String
downloading =
    "downloading"


settingsApplications: String
settingsApplications =
    "settings_applications"


compareArrows: String
compareArrows =
    "compare_arrows"


redo: String
redo =
    "redo"


publish: String
publish =
    "publish"


arrowLeft: String
arrowLeft =
    "arrow_left"


zoomOut: String
zoomOut =
    "zoom_out"


html: String
html =
    "html"


token: String
token =
    "token"


switchAccessShortcut: String
switchAccessShortcut =
    "switch_access_shortcut"


arrowCircleDown: String
arrowCircleDown =
    "arrow_circle_down"


fullscreenExit: String
fullscreenExit =
    "fullscreen_exit"


sortByAlpha: String
sortByAlpha =
    "sort_by_alpha"


deleteSweep: String
deleteSweep =
    "delete_sweep"


indeterminateCheckBox: String
indeterminateCheckBox =
    "indeterminate_check_box"


firstPage: String
firstPage =
    "first_page"


keyboardDoubleArrowUp: String
keyboardDoubleArrowUp =
    "keyboard_double_arrow_up"


viewTimeline: String
viewTimeline =
    "view_timeline"


settingsBackupRestore: String
settingsBackupRestore =
    "settings_backup_restore"


arrowDropDownCircle: String
arrowDropDownCircle =
    "arrow_drop_down_circle"


assistantNavigation: String
assistantNavigation =
    "assistant_navigation"


syncProblem: String
syncProblem =
    "sync_problem"


clearAll: String
clearAll =
    "clear_all"


densityMedium: String
densityMedium =
    "density_medium"


heartPlus: String
heartPlus =
    "heart_plus"


filterAltOff: String
filterAltOff =
    "filter_alt_off"


expand: String
expand =
    "expand"


lastPage: String
lastPage =
    "last_page"


subdirectoryArrowRight: String
subdirectoryArrowRight =
    "subdirectory_arrow_right"


downloadDone: String
downloadDone =
    "download_done"


unfoldLess: String
unfoldLess =
    "unfold_less"


arrowOutward: String
arrowOutward =
    "arrow_outward"


i123: String
i123 =
    "123"


swipeLeft: String
swipeLeft =
    "swipe_left"


savedSearch: String
savedSearch =
    "saved_search"


autoMode: String
autoMode =
    "auto_mode"


systemUpdateAlt: String
systemUpdateAlt =
    "system_update_alt"


placeItem: String
placeItem =
    "place_item"


maximize: String
maximize =
    "maximize"


javascript: String
javascript =
    "javascript"


output: String
output =
    "output"


searchOff: String
searchOff =
    "search_off"


fitScreen: String
fitScreen =
    "fit_screen"


selectAll: String
selectAll =
    "select_all"


swipeUp: String
swipeUp =
    "swipe_up"


dynamicForm: String
dynamicForm =
    "dynamic_form"


hideSource: String
hideSource =
    "hide_source"


swipeRight: String
swipeRight =
    "swipe_right"


switchAccessShortcutAdd: String
switchAccessShortcutAdd =
    "switch_access_shortcut_add"


browseGallery: String
browseGallery =
    "browse_gallery"


css: String
css =
    "css"


densitySmall: String
densitySmall =
    "density_small"


assistantDirection: String
assistantDirection =
    "assistant_direction"


checkSmall: String
checkSmall =
    "check_small"


fileDownloadDone: String
fileDownloadDone =
    "file_download_done"


youtubeSearchedFor: String
youtubeSearchedFor =
    "youtube_searched_for"


moveUp: String
moveUp =
    "move_up"


swapHorizontalCircle: String
swapHorizontalCircle =
    "swap_horizontal_circle"


dataThresholding: String
dataThresholding =
    "data_thresholding"


installMobile: String
installMobile =
    "install_mobile"


moveDown: String
moveDown =
    "move_down"


restoreFromTrash: String
restoreFromTrash =
    "restore_from_trash"


datasetLinked: String
datasetLinked =
    "dataset_linked"


abc: String
abc =
    "abc"


enable: String
enable =
    "enable"


installDesktop: String
installDesktop =
    "install_desktop"


keyboardCommandKey: String
keyboardCommandKey =
    "keyboard_command_key"


viewKanban: String
viewKanban =
    "view_kanban"


replyAll: String
replyAll =
    "reply_all"


browseActivity: String
browseActivity =
    "browse_activity"


switchLeft: String
switchLeft =
    "switch_left"


compress: String
compress =
    "compress"


swipeDown: String
swipeDown =
    "swipe_down"


swapVerticalCircle: String
swapVerticalCircle =
    "swap_vertical_circle"


removeDone: String
removeDone =
    "remove_done"


filterListOff: String
filterListOff =
    "filter_list_off"


appsOutage: String
appsOutage =
    "apps_outage"


switchRight: String
switchRight =
    "switch_right"


hide: String
hide =
    "hide"


swipeVertical: String
swipeVertical =
    "swipe_vertical"


moreUp: String
moreUp =
    "more_up"


starRate: String
starRate =
    "star_rate"


syncDisabled: String
syncDisabled =
    "sync_disabled"


pinch: String
pinch =
    "pinch"


keyboardControlKey: String
keyboardControlKey =
    "keyboard_control_key"


eject: String
eject =
    "eject"


keyOff: String
keyOff =
    "key_off"


php: String
php =
    "php"


subdirectoryArrowLeft: String
subdirectoryArrowLeft =
    "subdirectory_arrow_left"


viewCozy: String
viewCozy =
    "view_cozy"


doNotDisturbOff: String
doNotDisturbOff =
    "do_not_disturb_off"


transcribe: String
transcribe =
    "transcribe"


sendTimeExtension: String
sendTimeExtension =
    "send_time_extension"


widthNormal: String
widthNormal =
    "width_normal"


viewComfyAlt: String
viewComfyAlt =
    "view_comfy_alt"


heartMinus: String
heartMinus =
    "heart_minus"


shareReviews: String
shareReviews =
    "share_reviews"


widthFull: String
widthFull =
    "width_full"


unfoldMoreDouble: String
unfoldMoreDouble =
    "unfold_more_double"


viewCompactAlt: String
viewCompactAlt =
    "view_compact_alt"


fileDownloadOff: String
fileDownloadOff =
    "file_download_off"


extensionOff: String
extensionOff =
    "extension_off"


openInNewOff: String
openInNewOff =
    "open_in_new_off"


checkIndeterminateSmall: String
checkIndeterminateSmall =
    "check_indeterminate_small"


moreDown: String
moreDown =
    "more_down"


widthWide: String
widthWide =
    "width_wide"


repartition: String
repartition =
    "repartition"


swipeLeftAlt: String
swipeLeftAlt =
    "swipe_left_alt"


densityLarge: String
densityLarge =
    "density_large"


swipeDownAlt: String
swipeDownAlt =
    "swipe_down_alt"


swipeRightAlt: String
swipeRightAlt =
    "swipe_right_alt"


swipeUpAlt: String
swipeUpAlt =
    "swipe_up_alt"


unfoldLessDouble: String
unfoldLessDouble =
    "unfold_less_double"


keyboardOptionKey: String
keyboardOptionKey =
    "keyboard_option_key"


hls: String
hls =
    "hls"


hlsOff: String
hlsOff =
    "hls_off"


cycle: String
cycle =
    "cycle"


fileUploadOff: String
fileUploadOff =
    "file_upload_off"


rebase: String
rebase =
    "rebase"


rebaseEdit: String
rebaseEdit =
    "rebase_edit"


expandContent: String
expandContent =
    "expand_content"


emptyDashboard: String
emptyDashboard =
    "empty_dashboard"


magicExchange: String
magicExchange =
    "magic_exchange"


syncSavedLocally: String
syncSavedLocally =
    "sync_saved_locally"


quickReferenceAll: String
quickReferenceAll =
    "quick_reference_all"


acute: String
acute =
    "acute"


quickReference: String
quickReference =
    "quick_reference"


clockLoader60: String
clockLoader60 =
    "clock_loader_60"


preliminary: String
preliminary =
    "preliminary"


dataAlert: String
dataAlert =
    "data_alert"


dataCheck: String
dataCheck =
    "data_check"


dataInfoAlert: String
dataInfoAlert =
    "data_info_alert"


deployedCode: String
deployedCode =
    "deployed_code"


newWindow: String
newWindow =
    "new_window"


stepInto: String
stepInto =
    "step_into"


pointScan: String
pointScan =
    "point_scan"


searchCheck: String
searchCheck =
    "search_check"


magnificationSmall: String
magnificationSmall =
    "magnification_small"


magnificationLarge: String
magnificationLarge =
    "magnification_large"


captivePortal: String
captivePortal =
    "captive_portal"


starRateHalf: String
starRateHalf =
    "star_rate_half"


clockLoader40: String
clockLoader40 =
    "clock_loader_40"


clockLoader90: String
clockLoader90 =
    "clock_loader_90"


dragPan: String
dragPan =
    "drag_pan"


clockLoader10: String
clockLoader10 =
    "clock_loader_10"


leftClick: String
leftClick =
    "left_click"


patientList: String
patientList =
    "patient_list"


unknownMed: String
unknownMed =
    "unknown_med"


moveGroup: String
moveGroup =
    "move_group"


arrowInsert: String
arrowInsert =
    "arrow_insert"


leftPanelClose: String
leftPanelClose =
    "left_panel_close"


questionExchange: String
questionExchange =
    "question_exchange"


capture: String
capture =
    "capture"


chipExtraction: String
chipExtraction =
    "chip_extraction"


clockLoader20: String
clockLoader20 =
    "clock_loader_20"


iframe: String
iframe =
    "iframe"


chronic: String
chronic =
    "chronic"


inputCircle: String
inputCircle =
    "input_circle"


bottomRightClick: String
bottomRightClick =
    "bottom_right_click"


clockLoader80: String
clockLoader80 =
    "clock_loader_80"


goToLine: String
goToLine =
    "go_to_line"


leftPanelOpen: String
leftPanelOpen =
    "left_panel_open"


rightPanelClose: String
rightPanelClose =
    "right_panel_close"


shelfPosition: String
shelfPosition =
    "shelf_position"


rightClick: String
rightClick =
    "right_click"


errorMed: String
errorMed =
    "error_med"


resize: String
resize =
    "resize"


stepOut: String
stepOut =
    "step_out"


allMatch: String
allMatch =
    "all_match"


dragClick: String
dragClick =
    "drag_click"


step: String
step =
    "step"


stepOver: String
stepOver =
    "step_over"


appBadging: String
appBadging =
    "app_badging"


bottomPanelOpen: String
bottomPanelOpen =
    "bottom_panel_open"


outputCircle: String
outputCircle =
    "output_circle"


rightPanelOpen: String
rightPanelOpen =
    "right_panel_open"


amend: String
amend =
    "amend"


pip: String
pip =
    "pip"


arrowRange: String
arrowRange =
    "arrow_range"


arrowTopRight: String
arrowTopRight =
    "arrow_top_right"


eventList: String
eventList =
    "event_list"


jumpToElement: String
jumpToElement =
    "jump_to_element"


moveSelectionUp: String
moveSelectionUp =
    "move_selection_up"


shelfAutoHide: String
shelfAutoHide =
    "shelf_auto_hide"


arrowTopLeft: String
arrowTopLeft =
    "arrow_top_left"


arrowsOutward: String
arrowsOutward =
    "arrows_outward"


backToTab: String
backToTab =
    "back_to_tab"


bottomPanelClose: String
bottomPanelClose =
    "bottom_panel_close"


bubbles: String
bubbles =
    "bubbles"


iframeOff: String
iframeOff =
    "iframe_off"


moveSelectionDown: String
moveSelectionDown =
    "move_selection_down"


moveSelectionRight: String
moveSelectionRight =
    "move_selection_right"


openInNewDown: String
openInNewDown =
    "open_in_new_down"


positionBottomLeft: String
positionBottomLeft =
    "position_bottom_left"


positionBottomRight: String
positionBottomRight =
    "position_bottom_right"


positionTopRight: String
positionTopRight =
    "position_top_right"


reopenWindow: String
reopenWindow =
    "reopen_window"


ruleSettings: String
ruleSettings =
    "rule_settings"


switchAccess: String
switchAccess =
    "switch_access"


moveSelectionLeft: String
moveSelectionLeft =
    "move_selection_left"


pageInfo: String
pageInfo =
    "page_info"


pipExit: String
pipExit =
    "pip_exit"


shareWindows: String
shareWindows =
    "share_windows"


person: String
person =
    "person"


group: String
group =
    "group"


share: String
share =
    "share"


thumbUp: String
thumbUp =
    "thumb_up"


groups: String
groups =
    "groups"


personAdd: String
personAdd =
    "person_add"


public: String
public =
    "public"


handshake: String
handshake =
    "handshake"


supportAgent: String
supportAgent =
    "support_agent"


face: String
face =
    "face"


sentimentSatisfied: String
sentimentSatisfied =
    "sentiment_satisfied"


rocketLaunch: String
rocketLaunch =
    "rocket_launch"


groupAdd: String
groupAdd =
    "group_add"


workspacePremium: String
workspacePremium =
    "workspace_premium"


psychology: String
psychology =
    "psychology"


diversity3: String
diversity3 =
    "diversity_3"


emojiObjects: String
emojiObjects =
    "emoji_objects"


waterDrop: String
waterDrop =
    "water_drop"


eco: String
eco =
    "eco"


pets: String
pets =
    "pets"


travelExplore: String
travelExplore =
    "travel_explore"


mood: String
mood =
    "mood"


sunny: String
sunny =
    "sunny"


quiz: String
quiz =
    "quiz"


healthAndSafety: String
healthAndSafety =
    "health_and_safety"


sentimentDissatisfied: String
sentimentDissatisfied =
    "sentiment_dissatisfied"


sentimentVerySatisfied: String
sentimentVerySatisfied =
    "sentiment_very_satisfied"


militaryTech: String
militaryTech =
    "military_tech"


thumbDown: String
thumbDown =
    "thumb_down"


recycling: String
recycling =
    "recycling"


gavel: String
gavel =
    "gavel"


diamond: String
diamond =
    "diamond"


monitorHeart: String
monitorHeart =
    "monitor_heart"


emojiPeople: String
emojiPeople =
    "emoji_people"


diversity1: String
diversity1 =
    "diversity_1"


workspaces: String
workspaces =
    "workspaces"


vaccines: String
vaccines =
    "vaccines"


compost: String
compost =
    "compost"


forest: String
forest =
    "forest"


recommend: String
recommend =
    "recommend"


wavingHand: String
wavingHand =
    "waving_hand"


personRemove: String
personRemove =
    "person_remove"


wc: String
wc =
    "wc"


medication: String
medication =
    "medication"


groupWork: String
groupWork =
    "group_work"


sentimentVeryDissatisfied: String
sentimentVeryDissatisfied =
    "sentiment_very_dissatisfied"


sentimentNeutral: String
sentimentNeutral =
    "sentiment_neutral"


diversity2: String
diversity2 =
    "diversity_2"


frontHand: String
frontHand =
    "front_hand"


crueltyFree: String
crueltyFree =
    "cruelty_free"


man: String
man =
    "man"


medicalInformation: String
medicalInformation =
    "medical_information"


psychologyAlt: String
psychologyAlt =
    "psychology_alt"


coronavirus: String
coronavirus =
    "coronavirus"


addReaction: String
addReaction =
    "add_reaction"


rocket: String
rocket =
    "rocket"


female: String
female =
    "female"


pottedPlant: String
pottedPlant =
    "potted_plant"


emojiNature: String
emojiNature =
    "emoji_nature"


rainy: String
rainy =
    "rainy"


personOff: String
personOff =
    "person_off"


woman: String
woman =
    "woman"


connectWithoutContact: String
connectWithoutContact =
    "connect_without_contact"


cookie: String
cookie =
    "cookie"


male: String
male =
    "male"


moodBad: String
moodBad =
    "mood_bad"


bedtime: String
bedtime =
    "bedtime"


solarPower: String
solarPower =
    "solar_power"


thunderstorm: String
thunderstorm =
    "thunderstorm"


communication: String
communication =
    "communication"


groups2: String
groups2 =
    "groups_2"


partlyCloudyDay: String
partlyCloudyDay =
    "partly_cloudy_day"


cloudy: String
cloudy =
    "cloudy"


thumbsUpDown: String
thumbsUpDown =
    "thumbs_up_down"


emojiFlags: String
emojiFlags =
    "emoji_flags"


masks: String
masks =
    "masks"


hive: String
hive =
    "hive"


heartBroken: String
heartBroken =
    "heart_broken"


sentimentExtremelyDissatisfied: String
sentimentExtremelyDissatisfied =
    "sentiment_extremely_dissatisfied"


clearDay: String
clearDay =
    "clear_day"


boy: String
boy =
    "boy"


whatshot: String
whatshot =
    "whatshot"


cloudySnowing: String
cloudySnowing =
    "cloudy_snowing"


emojiFoodBeverage: String
emojiFoodBeverage =
    "emoji_food_beverage"


emojiTransportation: String
emojiTransportation =
    "emoji_transportation"


windPower: String
windPower =
    "wind_power"


elderly: String
elderly =
    "elderly"


face6: String
face6 =
    "face_6"


reduceCapacity: String
reduceCapacity =
    "reduce_capacity"


sick: String
sick =
    "sick"


pregnantWoman: String
pregnantWoman =
    "pregnant_woman"


face3: String
face3 =
    "face_3"


bloodtype: String
bloodtype =
    "bloodtype"


groupRemove: String
groupRemove =
    "group_remove"


medicationLiquid: String
medicationLiquid =
    "medication_liquid"


egg: String
egg =
    "egg"


groups3: String
groups3 =
    "groups_3"


clearNight: String
clearNight =
    "clear_night"


co2: String
co2 =
    "co2"


weight: String
weight =
    "weight"


followTheSigns: String
followTheSigns =
    "follow_the_signs"


skull: String
skull =
    "skull"


face4: String
face4 =
    "face_4"


oilBarrel: String
oilBarrel =
    "oil_barrel"


transgender: String
transgender =
    "transgender"


elderlyWoman: String
elderlyWoman =
    "elderly_woman"


cleanHands: String
cleanHands =
    "clean_hands"


sanitizer: String
sanitizer =
    "sanitizer"


person2: String
person2 =
    "person_2"


bringYourOwnIp: String
bringYourOwnIp =
    "bring_your_own_ip"


publicOff: String
publicOff =
    "public_off"


face2: String
face2 =
    "face_2"


socialDistance: String
socialDistance =
    "social_distance"


routine: String
routine =
    "routine"


signLanguage: String
signLanguage =
    "sign_language"


southAmerica: String
southAmerica =
    "south_america"


sunnySnowing: String
sunnySnowing =
    "sunny_snowing"


emojiSymbols: String
emojiSymbols =
    "emoji_symbols"


gardenCart: String
gardenCart =
    "garden_cart"


flood: String
flood =
    "flood"


eggAlt: String
eggAlt =
    "egg_alt"


face5: String
face5 =
    "face_5"


cyclone: String
cyclone =
    "cyclone"


girl: String
girl =
    "girl"


person4: String
person4 =
    "person_4"


dentistry: String
dentistry =
    "dentistry"


tsunami: String
tsunami =
    "tsunami"


groupOff: String
groupOff =
    "group_off"


outdoorGarden: String
outdoorGarden =
    "outdoor_garden"


partlyCloudyNight: String
partlyCloudyNight =
    "partly_cloudy_night"


severeCold: String
severeCold =
    "severe_cold"


snowing: String
snowing =
    "snowing"


person3: String
person3 =
    "person_3"


tornado: String
tornado =
    "tornado"


vapingRooms: String
vapingRooms =
    "vaping_rooms"


landslide: String
landslide =
    "landslide"


foggy: String
foggy =
    "foggy"


safetyDivider: String
safetyDivider =
    "safety_divider"


woman2: String
woman2 =
    "woman_2"


noAdultContent: String
noAdultContent =
    "no_adult_content"


volcano: String
volcano =
    "volcano"


man2: String
man2 =
    "man_2"


blind: String
blind =
    "blind"


i18UpRating: String
i18UpRating =
    "18_up_rating"


i6FtApart: String
i6FtApart =
    "6_ft_apart"


vapeFree: String
vapeFree =
    "vape_free"


notAccessible: String
notAccessible =
    "not_accessible"


man4: String
man4 =
    "man_4"


radiology: String
radiology =
    "radiology"


ribCage: String
ribCage =
    "rib_cage"


handBones: String
handBones =
    "hand_bones"


bedtimeOff: String
bedtimeOff =
    "bedtime_off"


rheumatology: String
rheumatology =
    "rheumatology"


man3: String
man3 =
    "man_3"


orthopedics: String
orthopedics =
    "orthopedics"


tibia: String
tibia =
    "tibia"


skeleton: String
skeleton =
    "skeleton"


humerus: String
humerus =
    "humerus"


agender: String
agender =
    "agender"


femur: String
femur =
    "femur"


footBones: String
footBones =
    "foot_bones"


tibiaAlt: String
tibiaAlt =
    "tibia_alt"


femurAlt: String
femurAlt =
    "femur_alt"


humerusAlt: String
humerusAlt =
    "humerus_alt"


ulnaRadius: String
ulnaRadius =
    "ulna_radius"


ulnaRadiusAlt: String
ulnaRadiusAlt =
    "ulna_radius_alt"


diversity4: String
diversity4 =
    "diversity_4"


specificGravity: String
specificGravity =
    "specific_gravity"


partnerExchange: String
partnerExchange =
    "partner_exchange"


breastfeeding: String
breastfeeding =
    "breastfeeding"


cognition: String
cognition =
    "cognition"


psychiatry: String
psychiatry =
    "psychiatry"


footprint: String
footprint =
    "footprint"


eyeglasses: String
eyeglasses =
    "eyeglasses"


labs: String
labs =
    "labs"


socialLeaderboard: String
socialLeaderboard =
    "social_leaderboard"


vitalSigns: String
vitalSigns =
    "vital_signs"


demography: String
demography =
    "demography"


neurology: String
neurology =
    "neurology"


nutrition: String
nutrition =
    "nutrition"


globeAsia: String
globeAsia =
    "globe_asia"


clinicalNotes: String
clinicalNotes =
    "clinical_notes"


stethoscope: String
stethoscope =
    "stethoscope"


sentimentExcited: String
sentimentExcited =
    "sentiment_excited"


altitude: String
altitude =
    "altitude"


labResearch: String
labResearch =
    "lab_research"


homeHealth: String
homeHealth =
    "home_health"


recentPatient: String
recentPatient =
    "recent_patient"


dewPoint: String
dewPoint =
    "dew_point"


conditions: String
conditions =
    "conditions"


prayerTimes: String
prayerTimes =
    "prayer_times"


shareOff: String
shareOff =
    "share_off"


globeUk: String
globeUk =
    "globe_uk"


metabolism: String
metabolism =
    "metabolism"


sentimentContent: String
sentimentContent =
    "sentiment_content"


sentimentSad: String
sentimentSad =
    "sentiment_sad"


sentimentStressed: String
sentimentStressed =
    "sentiment_stressed"


taunt: String
taunt =
    "taunt"


cardiology: String
cardiology =
    "cardiology"


stethoscopeCheck: String
stethoscopeCheck =
    "stethoscope_check"


wrist: String
wrist =
    "wrist"


glucose: String
glucose =
    "glucose"


infrared: String
infrared =
    "infrared"


sentimentFrustrated: String
sentimentFrustrated =
    "sentiment_frustrated"


barefoot: String
barefoot =
    "barefoot"


microbiology: String
microbiology =
    "microbiology"


sentimentCalm: String
sentimentCalm =
    "sentiment_calm"


stethoscopeArrow: String
stethoscopeArrow =
    "stethoscope_arrow"


bodySystem: String
bodySystem =
    "body_system"


cookieOff: String
cookieOff =
    "cookie_off"


earthquake: String
earthquake =
    "earthquake"


ent: String
ent =
    "ent"


oncology: String
oncology =
    "oncology"


shortStay: String
shortStay =
    "short_stay"


waterLux: String
waterLux =
    "water_lux"


waterVoc: String
waterVoc =
    "water_voc"


allergies: String
allergies =
    "allergies"


deceased: String
deceased =
    "deceased"


endocrinology: String
endocrinology =
    "endocrinology"


explosion: String
explosion =
    "explosion"


genetics: String
genetics =
    "genetics"


gynecology: String
gynecology =
    "gynecology"


hematology: String
hematology =
    "hematology"


mixtureMed: String
mixtureMed =
    "mixture_med"


ophthalmology: String
ophthalmology =
    "ophthalmology"


oxygenSaturation: String
oxygenSaturation =
    "oxygen_saturation"


prescriptions: String
prescriptions =
    "prescriptions"


pulmonology: String
pulmonology =
    "pulmonology"


ward: String
ward =
    "ward"


allergy: String
allergy =
    "allergy"


bodyFat: String
bodyFat =
    "body_fat"


cheer: String
cheer =
    "cheer"


congenital: String
congenital =
    "congenital"


dermatology: String
dermatology =
    "dermatology"


emoticon: String
emoticon =
    "emoticon"


humidityPercentage: String
humidityPercentage =
    "humidity_percentage"


immunology: String
immunology =
    "immunology"


inpatient: String
inpatient =
    "inpatient"


labPanel: String
labPanel =
    "lab_panel"


medicalMask: String
medicalMask =
    "medical_mask"


movingBeds: String
movingBeds =
    "moving_beds"


nephrology: String
nephrology =
    "nephrology"


oralDisease: String
oralDisease =
    "oral_disease"


outpatient: String
outpatient =
    "outpatient"


outpatientMed: String
outpatientMed =
    "outpatient_med"


pediatrics: String
pediatrics =
    "pediatrics"


salinity: String
salinity =
    "salinity"


sentimentWorried: String
sentimentWorried =
    "sentiment_worried"


surgical: String
surgical =
    "surgical"


symptoms: String
symptoms =
    "symptoms"


syringe: String
syringe =
    "syringe"


urology: String
urology =
    "urology"


waterDo: String
waterDo =
    "water_do"


waterOrp: String
waterOrp =
    "water_orp"


waterPh: String
waterPh =
    "water_ph"


woundsInjuries: String
woundsInjuries =
    "wounds_injuries"


adminMeds: String
adminMeds =
    "admin_meds"


fluid: String
fluid =
    "fluid"


fluidBalance: String
fluidBalance =
    "fluid_balance"


fluidMed: String
fluidMed =
    "fluid_med"


gastroenterology: String
gastroenterology =
    "gastroenterology"


pill: String
pill =
    "pill"


pillOff: String
pillOff =
    "pill_off"


respiratoryRate: String
respiratoryRate =
    "respiratory_rate"


totalDissolvedSolids: String
totalDissolvedSolids =
    "total_dissolved_solids"


waterBottle: String
waterBottle =
    "water_bottle"


weatherHail: String
weatherHail =
    "weather_hail"


mist: String
mist =
    "mist"


procedure: String
procedure =
    "procedure"


rainyHeavy: String
rainyHeavy =
    "rainy_heavy"


rainyLight: String
rainyLight =
    "rainy_light"


rainySnow: String
rainySnow =
    "rainy_snow"


snowingHeavy: String
snowingHeavy =
    "snowing_heavy"


waterBottleLarge: String
waterBottleLarge =
    "water_bottle_large"


waterEc: String
waterEc =
    "water_ec"


accountCircle: String
accountCircle =
    "account_circle"


info: String
info =
    "info"


visibility: String
visibility =
    "visibility"


calendarMonth: String
calendarMonth =
    "calendar_month"


schedule: String
schedule =
    "schedule"


help: String
help =
    "help"


language: String
language =
    "language"


warning: String
warning =
    "warning"


lock: String
lock =
    "lock"


error: String
error =
    "error"


visibilityOff: String
visibilityOff =
    "visibility_off"


verified: String
verified =
    "verified"


manageAccounts: String
manageAccounts =
    "manage_accounts"


taskAlt: String
taskAlt =
    "task_alt"


history: String
history =
    "history"


event: String
event =
    "event"


bookmark: String
bookmark =
    "bookmark"


calendarToday: String
calendarToday =
    "calendar_today"


tipsAndUpdates: String
tipsAndUpdates =
    "tips_and_updates"


questionMark: String
questionMark =
    "question_mark"


lightbulb: String
lightbulb =
    "lightbulb"


fingerprint: String
fingerprint =
    "fingerprint"


category: String
category =
    "category"


update: String
update =
    "update"


lockOpen: String
lockOpen =
    "lock_open"


priorityHigh: String
priorityHigh =
    "priority_high"


code: String
code =
    "code"


build: String
build =
    "build"


dateRange: String
dateRange =
    "date_range"


uploadFile: String
uploadFile =
    "upload_file"


supervisorAccount: String
supervisorAccount =
    "supervisor_account"


eventAvailable: String
eventAvailable =
    "event_available"


adsClick: String
adsClick =
    "ads_click"


today: String
today =
    "today"


settingsSuggest: String
settingsSuggest =
    "settings_suggest"


touchApp: String
touchApp =
    "touch_app"


preview: String
preview =
    "preview"


pending: String
pending =
    "pending"


stars: String
stars =
    "stars"


newReleases: String
newReleases =
    "new_releases"


accountBox: String
accountBox =
    "account_box"


celebration: String
celebration =
    "celebration"


howToReg: String
howToReg =
    "how_to_reg"


translate: String
translate =
    "translate"


bugReport: String
bugReport =
    "bug_report"


pushPin: String
pushPin =
    "push_pin"


alarm: String
alarm =
    "alarm"


editCalendar: String
editCalendar =
    "edit_calendar"


editSquare: String
editSquare =
    "edit_square"


label: String
label =
    "label"


eventNote: String
eventNote =
    "event_note"


extension: String
extension =
    "extension"


rateReview: String
rateReview =
    "rate_review"


recordVoiceOver: String
recordVoiceOver =
    "record_voice_over"


web: String
web =
    "web"


hourglassEmpty: String
hourglassEmpty =
    "hourglass_empty"


publishedWithChanges: String
publishedWithChanges =
    "published_with_changes"


support: String
support =
    "support"


notificationImportant: String
notificationImportant =
    "notification_important"


helpCenter: String
helpCenter =
    "help_center"


upload: String
upload =
    "upload"


accessibilityNew: String
accessibilityNew =
    "accessibility_new"


bookmarks: String
bookmarks =
    "bookmarks"


panToolAlt: String
panToolAlt =
    "pan_tool_alt"


supervisedUserCircle: String
supervisedUserCircle =
    "supervised_user_circle"


collectionsBookmark: String
collectionsBookmark =
    "collections_bookmark"


dangerous: String
dangerous =
    "dangerous"


interests: String
interests =
    "interests"


allInclusive: String
allInclusive =
    "all_inclusive"


rule: String
rule =
    "rule"


changeHistory: String
changeHistory =
    "change_history"


priority: String
priority =
    "priority"


eventUpcoming: String
eventUpcoming =
    "event_upcoming"


buildCircle: String
buildCircle =
    "build_circle"


wysiwyg: String
wysiwyg =
    "wysiwyg"


panTool: String
panTool =
    "pan_tool"


api: String
api =
    "api"


circleNotifications: String
circleNotifications =
    "circle_notifications"


hotelClass: String
hotelClass =
    "hotel_class"


manageHistory: String
manageHistory =
    "manage_history"


accessible: String
accessible =
    "accessible"


webAsset: String
webAsset =
    "web_asset"


upgrade: String
upgrade =
    "upgrade"


lockReset: String
lockReset =
    "lock_reset"


bookmarkAdd: String
bookmarkAdd =
    "bookmark_add"


input: String
input =
    "input"


eventBusy: String
eventBusy =
    "event_busy"


flutterDash: String
flutterDash =
    "flutter_dash"


moreTime: String
moreTime =
    "more_time"


saveAs: String
saveAs =
    "save_as"


backup: String
backup =
    "backup"


modelTraining: String
modelTraining =
    "model_training"


accessibility: String
accessibility =
    "accessibility"


alarmOn: String
alarmOn =
    "alarm_on"


dynamicFeed: String
dynamicFeed =
    "dynamic_feed"


pageview: String
pageview =
    "pageview"


homeAppLogo: String
homeAppLogo =
    "home_app_logo"


permContactCalendar: String
permContactCalendar =
    "perm_contact_calendar"


labelImportant: String
labelImportant =
    "label_important"


historyToggleOff: String
historyToggleOff =
    "history_toggle_off"


squareFoot: String
squareFoot =
    "square_foot"


approval: String
approval =
    "approval"


more: String
more =
    "more"


swipe: String
swipe =
    "swipe"


assistant: String
assistant =
    "assistant"


componentExchange: String
componentExchange =
    "component_exchange"


eventRepeat: String
eventRepeat =
    "event_repeat"


bookmarkAdded: String
bookmarkAdded =
    "bookmark_added"


appShortcut: String
appShortcut =
    "app_shortcut"


openInBrowser: String
openInBrowser =
    "open_in_browser"


unpublished: String
unpublished =
    "unpublished"


offlineBolt: String
offlineBolt =
    "offline_bolt"


notificationAdd: String
notificationAdd =
    "notification_add"


noAccounts: String
noAccounts =
    "no_accounts"


freeCancellation: String
freeCancellation =
    "free_cancellation"


backgroundReplace: String
backgroundReplace =
    "background_replace"


runningWithErrors: String
runningWithErrors =
    "running_with_errors"


anchor: String
anchor =
    "anchor"


webhook: String
webhook =
    "webhook"


hourglassFull: String
hourglassFull =
    "hourglass_full"


i3dRotation: String
i3dRotation =
    "3d_rotation"


lockPerson: String
lockPerson =
    "lock_person"


newLabel: String
newLabel =
    "new_label"


lockClock: String
lockClock =
    "lock_clock"


accessibleForward: String
accessibleForward =
    "accessible_forward"


autoDelete: String
autoDelete =
    "auto_delete"


addAlert: String
addAlert =
    "add_alert"


domainVerification: String
domainVerification =
    "domain_verification"


smartButton: String
smartButton =
    "smart_button"


outbound: String
outbound =
    "outbound"


handGesture: String
handGesture =
    "hand_gesture"


settingsPower: String
settingsPower =
    "settings_power"


tab: String
tab =
    "tab"


chromeReaderMode: String
chromeReaderMode =
    "chrome_reader_mode"


onlinePrediction: String
onlinePrediction =
    "online_prediction"


gesture: String
gesture =
    "gesture"


editNotifications: String
editNotifications =
    "edit_notifications"


generatingTokens: String
generatingTokens =
    "generating_tokens"


lightbulbCircle: String
lightbulbCircle =
    "lightbulb_circle"


findReplace: String
findReplace =
    "find_replace"


backupTable: String
backupTable =
    "backup_table"


offlinePin: String
offlinePin =
    "offline_pin"


wifiProtectedSetup: String
wifiProtectedSetup =
    "wifi_protected_setup"


adUnits: String
adUnits =
    "ad_units"


http: String
http =
    "http"


bookmarkRemove: String
bookmarkRemove =
    "bookmark_remove"


alarmAdd: String
alarmAdd =
    "alarm_add"


pinchZoomOut: String
pinchZoomOut =
    "pinch_zoom_out"


onDeviceTraining: String
onDeviceTraining =
    "on_device_training"


snooze: String
snooze =
    "snooze"


codeOff: String
codeOff =
    "code_off"


batchPrediction: String
batchPrediction =
    "batch_prediction"


pinchZoomIn: String
pinchZoomIn =
    "pinch_zoom_in"


commit: String
commit =
    "commit"


hourglassDisabled: String
hourglassDisabled =
    "hourglass_disabled"


settingsOverscan: String
settingsOverscan =
    "settings_overscan"


polymer: String
polymer =
    "polymer"


logoDev: String
logoDev =
    "logo_dev"


youtubeActivity: String
youtubeActivity =
    "youtube_activity"


timeAuto: String
timeAuto =
    "time_auto"


personAddDisabled: String
personAddDisabled =
    "person_add_disabled"


voiceOverOff: String
voiceOverOff =
    "voice_over_off"


alarmOff: String
alarmOff =
    "alarm_off"


updateDisabled: String
updateDisabled =
    "update_disabled"


timer10Alt1: String
timer10Alt1 =
    "timer_10_alt_1"


roundedCorner: String
roundedCorner =
    "rounded_corner"


labelOff: String
labelOff =
    "label_off"


allOut: String
allOut =
    "all_out"


timer3Alt1: String
timer3Alt1 =
    "timer_3_alt_1"


tabUnselected: String
tabUnselected =
    "tab_unselected"


rsvp: String
rsvp =
    "rsvp"


webAssetOff: String
webAssetOff =
    "web_asset_off"


pinInvoke: String
pinInvoke =
    "pin_invoke"


pinEnd: String
pinEnd =
    "pin_end"


codeBlocks: String
codeBlocks =
    "code_blocks"


approvalDelegation: String
approvalDelegation =
    "approval_delegation"


arrowSelectorTool: String
arrowSelectorTool =
    "arrow_selector_tool"


problem: String
problem =
    "problem"


autoLabel: String
autoLabel =
    "auto_label"


awardStar: String
awardStar =
    "award_star"


visibilityLock: String
visibilityLock =
    "visibility_lock"


settingsAccountBox: String
settingsAccountBox =
    "settings_account_box"


releaseAlert: String
releaseAlert =
    "release_alert"


draftOrders: String
draftOrders =
    "draft_orders"


panZoom: String
panZoom =
    "pan_zoom"


accountCircleOff: String
accountCircleOff =
    "account_circle_off"


alarmSmartWake: String
alarmSmartWake =
    "alarm_smart_wake"


bookmarkManager: String
bookmarkManager =
    "bookmark_manager"


helpClinic: String
helpClinic =
    "help_clinic"


shift: String
shift =
    "shift"


watchScreentime: String
watchScreentime =
    "watch_screentime"


previewOff: String
previewOff =
    "preview_off"


lockOpenRight: String
lockOpenRight =
    "lock_open_right"


measuringTape: String
measuringTape =
    "measuring_tape"


shiftLock: String
shiftLock =
    "shift_lock"


domainVerificationOff: String
domainVerificationOff =
    "domain_verification_off"


warningOff: String
warningOff =
    "warning_off"


waterLock: String
waterLock =
    "water_lock"


adOff: String
adOff =
    "ad_off"


gestureSelect: String
gestureSelect =
    "gesture_select"


mail: String
mail =
    "mail"


call: String
call =
    "call"


notifications: String
notifications =
    "notifications"


send: String
send =
    "send"


chat: String
chat =
    "chat"


link: String
link =
    "link"


forum: String
forum =
    "forum"


inventory2: String
inventory2 =
    "inventory_2"


phoneInTalk: String
phoneInTalk =
    "phone_in_talk"


contactSupport: String
contactSupport =
    "contact_support"


chatBubble: String
chatBubble =
    "chat_bubble"


notificationsActive: String
notificationsActive =
    "notifications_active"


alternateEmail: String
alternateEmail =
    "alternate_email"


sms: String
sms =
    "sms"


comment: String
comment =
    "comment"


powerSettingsNew: String
powerSettingsNew =
    "power_settings_new"


hub: String
hub =
    "hub"


personSearch: String
personSearch =
    "person_search"


importContacts: String
importContacts =
    "import_contacts"


contactMail: String
contactMail =
    "contact_mail"


contacts: String
contacts =
    "contacts"


liveHelp: String
liveHelp =
    "live_help"


forwardToInbox: String
forwardToInbox =
    "forward_to_inbox"


markEmailUnread: String
markEmailUnread =
    "mark_email_unread"


lan: String
lan =
    "lan"


reviews: String
reviews =
    "reviews"


contactPhone: String
contactPhone =
    "contact_phone"


modeComment: String
modeComment =
    "mode_comment"


hourglassTop: String
hourglassTop =
    "hourglass_top"


inbox: String
inbox =
    "inbox"


outgoingMail: String
outgoingMail =
    "outgoing_mail"


drafts: String
drafts =
    "drafts"


hourglassBottom: String
hourglassBottom =
    "hourglass_bottom"


markEmailRead: String
markEmailRead =
    "mark_email_read"


smsFailed: String
smsFailed =
    "sms_failed"


linkOff: String
linkOff =
    "link_off"


calendarAddOn: String
calendarAddOn =
    "calendar_add_on"


phoneEnabled: String
phoneEnabled =
    "phone_enabled"


addComment: String
addComment =
    "add_comment"


speakerNotes: String
speakerNotes =
    "speaker_notes"


permPhoneMsg: String
permPhoneMsg =
    "perm_phone_msg"


coPresent: String
coPresent =
    "co_present"


topic: String
topic =
    "topic"


callEnd: String
callEnd =
    "call_end"


notificationsOff: String
notificationsOff =
    "notifications_off"


cellTower: String
cellTower =
    "cell_tower"


markChatUnread: String
markChatUnread =
    "mark_chat_unread"


scheduleSend: String
scheduleSend =
    "schedule_send"


dialpad: String
dialpad =
    "dialpad"


callMade: String
callMade =
    "call_made"


satelliteAlt: String
satelliteAlt =
    "satellite_alt"


markUnreadChatAlt: String
markUnreadChatAlt =
    "mark_unread_chat_alt"


unarchive: String
unarchive =
    "unarchive"


i3p: String
i3p =
    "3p"


cancelPresentation: String
cancelPresentation =
    "cancel_presentation"


markAsUnread: String
markAsUnread =
    "mark_as_unread"


moveToInbox: String
moveToInbox =
    "move_to_inbox"


attachEmail: String
attachEmail =
    "attach_email"


phonelinkRing: String
phonelinkRing =
    "phonelink_ring"


nextPlan: String
nextPlan =
    "next_plan"


unsubscribe: String
unsubscribe =
    "unsubscribe"


phoneCallback: String
phoneCallback =
    "phone_callback"


callReceived: String
callReceived =
    "call_received"


settingsPhone: String
settingsPhone =
    "settings_phone"


callSplit: String
callSplit =
    "call_split"


presentToAll: String
presentToAll =
    "present_to_all"


addCall: String
addCall =
    "add_call"


markunreadMailbox: String
markunreadMailbox =
    "markunread_mailbox"


allInbox: String
allInbox =
    "all_inbox"


phoneForwarded: String
phoneForwarded =
    "phone_forwarded"


voiceChat: String
voiceChat =
    "voice_chat"


mailLock: String
mailLock =
    "mail_lock"


attribution: String
attribution =
    "attribution"


voicemail: String
voicemail =
    "voicemail"


duo: String
duo =
    "duo"


contactEmergency: String
contactEmergency =
    "contact_emergency"


markChatRead: String
markChatRead =
    "mark_chat_read"


upcoming: String
upcoming =
    "upcoming"


outbox: String
outbox =
    "outbox"


phoneDisabled: String
phoneDisabled =
    "phone_disabled"


swapCalls: String
swapCalls =
    "swap_calls"


phonelinkLock: String
phonelinkLock =
    "phonelink_lock"


spoke: String
spoke =
    "spoke"


cancelScheduleSend: String
cancelScheduleSend =
    "cancel_schedule_send"


notificationsPaused: String
notificationsPaused =
    "notifications_paused"


ringVolume: String
ringVolume =
    "ring_volume"


pictureInPictureAlt: String
pictureInPictureAlt =
    "picture_in_picture_alt"


quickreply: String
quickreply =
    "quickreply"


phoneMissed: String
phoneMissed =
    "phone_missed"


commentBank: String
commentBank =
    "comment_bank"


sendAndArchive: String
sendAndArchive =
    "send_and_archive"


chatAddOn: String
chatAddOn =
    "chat_add_on"


settingsBluetooth: String
settingsBluetooth =
    "settings_bluetooth"


phonelinkErase: String
phonelinkErase =
    "phonelink_erase"


pictureInPicture: String
pictureInPicture =
    "picture_in_picture"


commentsDisabled: String
commentsDisabled =
    "comments_disabled"


videoChat: String
videoChat =
    "video_chat"


score: String
score =
    "score"


pausePresentation: String
pausePresentation =
    "pause_presentation"


cellWifi: String
cellWifi =
    "cell_wifi"


speakerPhone: String
speakerPhone =
    "speaker_phone"


speakerNotesOff: String
speakerNotesOff =
    "speaker_notes_off"


autoReadPlay: String
autoReadPlay =
    "auto_read_play"


mms: String
mms =
    "mms"


callMerge: String
callMerge =
    "call_merge"


playForWork: String
playForWork =
    "play_for_work"


callMissedOutgoing: String
callMissedOutgoing =
    "call_missed_outgoing"


wifiChannel: String
wifiChannel =
    "wifi_channel"


callMissed: String
callMissed =
    "call_missed"


calendarAppsScript: String
calendarAppsScript =
    "calendar_apps_script"


phonePaused: String
phonePaused =
    "phone_paused"


rtt: String
rtt =
    "rtt"


autoReadPause: String
autoReadPause =
    "auto_read_pause"


phoneLocked: String
phoneLocked =
    "phone_locked"


wifiCalling: String
wifiCalling =
    "wifi_calling"


dialerSip: String
dialerSip =
    "dialer_sip"


nat: String
nat =
    "nat"


chatAppsScript: String
chatAppsScript =
    "chat_apps_script"


sip: String
sip =
    "sip"


phoneBluetoothSpeaker: String
phoneBluetoothSpeaker =
    "phone_bluetooth_speaker"


e911Avatar: String
e911Avatar =
    "e911_avatar"


inboxCustomize: String
inboxCustomize =
    "inbox_customize"


chatError: String
chatError =
    "chat_error"


chatPasteGo: String
chatPasteGo =
    "chat_paste_go"


phonelinkRingOff: String
phonelinkRingOff =
    "phonelink_ring_off"


networkManage: String
networkManage =
    "network_manage"


signalCellularAdd: String
signalCellularAdd =
    "signal_cellular_add"


wifiProxy: String
wifiProxy =
    "wifi_proxy"


callLog: String
callLog =
    "call_log"


callQuality: String
callQuality =
    "call_quality"


wifiAdd: String
wifiAdd =
    "wifi_add"


edit: String
edit =
    "edit"


photoCamera: String
photoCamera =
    "photo_camera"


filterAlt: String
filterAlt =
    "filter_alt"


image: String
image =
    "image"


navigateNext: String
navigateNext =
    "navigate_next"


tune: String
tune =
    "tune"


timer: String
timer =
    "timer"


pictureAsPdf: String
pictureAsPdf =
    "picture_as_pdf"


circle: String
circle =
    "circle"


palette: String
palette =
    "palette"


autoAwesome: String
autoAwesome =
    "auto_awesome"


addAPhoto: String
addAPhoto =
    "add_a_photo"


photoLibrary: String
photoLibrary =
    "photo_library"


magicButton: String
magicButton =
    "magic_button"


navigateBefore: String
navigateBefore =
    "navigate_before"


autoStories: String
autoStories =
    "auto_stories"


addPhotoAlternate: String
addPhotoAlternate =
    "add_photo_alternate"


brush: String
brush =
    "brush"


imagesmode: String
imagesmode =
    "imagesmode"


nature: String
nature =
    "nature"


flashOn: String
flashOn =
    "flash_on"


wbSunny: String
wbSunny =
    "wb_sunny"


camera: String
camera =
    "camera"


straighten: String
straighten =
    "straighten"


looksOne: String
looksOne =
    "looks_one"


landscape: String
landscape =
    "landscape"


timelapse: String
timelapse =
    "timelapse"


slideshow: String
slideshow =
    "slideshow"


gridOn: String
gridOn =
    "grid_on"


rotateRight: String
rotateRight =
    "rotate_right"


cropSquare: String
cropSquare =
    "crop_square"


adjust: String
adjust =
    "adjust"


style: String
style =
    "style"


cropFree: String
cropFree =
    "crop_free"


aspectRatio: String
aspectRatio =
    "aspect_ratio"


brightness6: String
brightness6 =
    "brightness_6"


photo: String
photo =
    "photo"


naturePeople: String
naturePeople =
    "nature_people"


filterVintage: String
filterVintage =
    "filter_vintage"


crop: String
crop =
    "crop"


imageSearch: String
imageSearch =
    "image_search"


movieFilter: String
movieFilter =
    "movie_filter"


blurOn: String
blurOn =
    "blur_on"


centerFocusStrong: String
centerFocusStrong =
    "center_focus_strong"


contrast: String
contrast =
    "contrast"


faceRetouchingNatural: String
faceRetouchingNatural =
    "face_retouching_natural"


compare: String
compare =
    "compare"


looksTwo: String
looksTwo =
    "looks_two"


rotateLeft: String
rotateLeft =
    "rotate_left"


colorize: String
colorize =
    "colorize"


flare: String
flare =
    "flare"


filterNone: String
filterNone =
    "filter_none"


wbIncandescent: String
wbIncandescent =
    "wb_incandescent"


filterDrama: String
filterDrama =
    "filter_drama"


healing: String
healing =
    "healing"


looks3: String
looks3 =
    "looks_3"


wbTwilight: String
wbTwilight =
    "wb_twilight"


brightness5: String
brightness5 =
    "brightness_5"


invertColors: String
invertColors =
    "invert_colors"


lens: String
lens =
    "lens"


animation: String
animation =
    "animation"


opacity: String
opacity =
    "opacity"


incompleteCircle: String
incompleteCircle =
    "incomplete_circle"


brokenImage: String
brokenImage =
    "broken_image"


filterCenterFocus: String
filterCenterFocus =
    "filter_center_focus"


addToPhotos: String
addToPhotos =
    "add_to_photos"


brightness4: String
brightness4 =
    "brightness_4"


flip: String
flip =
    "flip"


flashOff: String
flashOff =
    "flash_off"


centerFocusWeak: String
centerFocusWeak =
    "center_focus_weak"


autoAwesomeMotion: String
autoAwesomeMotion =
    "auto_awesome_motion"


micExternalOn: String
micExternalOn =
    "mic_external_on"


flipCameraAndroid: String
flipCameraAndroid =
    "flip_camera_android"


lensBlur: String
lensBlur =
    "lens_blur"


details: String
details =
    "details"


grain: String
grain =
    "grain"


noPhotography: String
noPhotography =
    "no_photography"


panorama: String
panorama =
    "panorama"


imageNotSupported: String
imageNotSupported =
    "image_not_supported"


webStories: String
webStories =
    "web_stories"


dehaze: String
dehaze =
    "dehaze"


gifBox: String
gifBox =
    "gif_box"


flaky: String
flaky =
    "flaky"


loupe: String
loupe =
    "loupe"


exposurePlus1: String
exposurePlus1 =
    "exposure_plus_1"


settingsBrightness: String
settingsBrightness =
    "settings_brightness"


texture: String
texture =
    "texture"


autoAwesomeMosaic: String
autoAwesomeMosaic =
    "auto_awesome_mosaic"


looks4: String
looks4 =
    "looks_4"


filter1: String
filter1 =
    "filter_1"


timerOff: String
timerOff =
    "timer_off"


flipCameraIos: String
flipCameraIos =
    "flip_camera_ios"


cameraEnhance: String
cameraEnhance =
    "camera_enhance"


panoramaFishEye: String
panoramaFishEye =
    "panorama_fish_eye"


filter: String
filter =
    "filter"


viewCompact: String
viewCompact =
    "view_compact"


brightness1: String
brightness1 =
    "brightness_1"


photoCameraFront: String
photoCameraFront =
    "photo_camera_front"


controlPointDuplicate: String
controlPointDuplicate =
    "control_point_duplicate"


photoAlbum: String
photoAlbum =
    "photo_album"


brightness7: String
brightness7 =
    "brightness_7"


transform: String
transform =
    "transform"


linkedCamera: String
linkedCamera =
    "linked_camera"


viewComfy: String
viewComfy =
    "view_comfy"


crop169: String
crop169 =
    "crop_16_9"


looks: String
looks =
    "looks"


hideImage: String
hideImage =
    "hide_image"


looks5: String
looks5 =
    "looks_5"


exposure: String
exposure =
    "exposure"


photoFilter: String
photoFilter =
    "photo_filter"


rotate90DegreesCcw: String
rotate90DegreesCcw =
    "rotate_90_degrees_ccw"


filterHdr: String
filterHdr =
    "filter_hdr"


brightness3: String
brightness3 =
    "brightness_3"


gif: String
gif =
    "gif"


leakAdd: String
leakAdd =
    "leak_add"


hdrStrong: String
hdrStrong =
    "hdr_strong"


crop75: String
crop75 =
    "crop_7_5"


gradient: String
gradient =
    "gradient"


vrpano: String
vrpano =
    "vrpano"


cameraRoll: String
cameraRoll =
    "camera_roll"


cropPortrait: String
cropPortrait =
    "crop_portrait"


hdrAuto: String
hdrAuto =
    "hdr_auto"


blurCircular: String
blurCircular =
    "blur_circular"


motionPhotosAuto: String
motionPhotosAuto =
    "motion_photos_auto"


rotate90DegreesCw: String
rotate90DegreesCw =
    "rotate_90_degrees_cw"


brightness2: String
brightness2 =
    "brightness_2"


photoSizeSelectSmall: String
photoSizeSelectSmall =
    "photo_size_select_small"


shutterSpeed: String
shutterSpeed =
    "shutter_speed"


looks6: String
looks6 =
    "looks_6"


cameraFront: String
cameraFront =
    "camera_front"


flashAuto: String
flashAuto =
    "flash_auto"


filter2: String
filter2 =
    "filter_2"


cropLandscape: String
cropLandscape =
    "crop_landscape"


filterTiltShift: String
filterTiltShift =
    "filter_tilt_shift"


deblur: String
deblur =
    "deblur"


monochromePhotos: String
monochromePhotos =
    "monochrome_photos"


astrophotographyAuto: String
astrophotographyAuto =
    "astrophotography_auto"


crop54: String
crop54 =
    "crop_5_4"


hdrWeak: String
hdrWeak =
    "hdr_weak"


nightSightAuto: String
nightSightAuto =
    "night_sight_auto"


filter4: String
filter4 =
    "filter_4"


filter3: String
filter3 =
    "filter_3"


motionPhotosPaused: String
motionPhotosPaused =
    "motion_photos_paused"


cropRotate: String
cropRotate =
    "crop_rotate"


crop32: String
crop32 =
    "crop_3_2"


tonality: String
tonality =
    "tonality"


switchCamera: String
switchCamera =
    "switch_camera"


photoFrame: String
photoFrame =
    "photo_frame"


exposureZero: String
exposureZero =
    "exposure_zero"


photoSizeSelectLarge: String
photoSizeSelectLarge =
    "photo_size_select_large"


macroOff: String
macroOff =
    "macro_off"


filterFrames: String
filterFrames =
    "filter_frames"


evShadow: String
evShadow =
    "ev_shadow"


fluorescent: String
fluorescent =
    "fluorescent"


partyMode: String
partyMode =
    "party_mode"


rawOn: String
rawOn =
    "raw_on"


motionBlur: String
motionBlur =
    "motion_blur"


exposurePlus2: String
exposurePlus2 =
    "exposure_plus_2"


photoCameraBack: String
photoCameraBack =
    "photo_camera_back"


blurLinear: String
blurLinear =
    "blur_linear"


exposureNeg1: String
exposureNeg1 =
    "exposure_neg_1"


wbIridescent: String
wbIridescent =
    "wb_iridescent"


filterBAndW: String
filterBAndW =
    "filter_b_and_w"


panoramaHorizontal: String
panoramaHorizontal =
    "panorama_horizontal"


switchVideo: String
switchVideo =
    "switch_video"


motionPhotosOff: String
motionPhotosOff =
    "motion_photos_off"


filter5: String
filter5 =
    "filter_5"


blurMedium: String
blurMedium =
    "blur_medium"


invertColorsOff: String
invertColorsOff =
    "invert_colors_off"


filter7: String
filter7 =
    "filter_7"


faceRetouchingOff: String
faceRetouchingOff =
    "face_retouching_off"


burstMode: String
burstMode =
    "burst_mode"


panoramaPhotosphere: String
panoramaPhotosphere =
    "panorama_photosphere"


hdrOn: String
hdrOn =
    "hdr_on"


gridOff: String
gridOff =
    "grid_off"


filter9Plus: String
filter9Plus =
    "filter_9_plus"


filter8: String
filter8 =
    "filter_8"


autoFix: String
autoFix =
    "auto_fix"


blurShort: String
blurShort =
    "blur_short"


filter9: String
filter9 =
    "filter_9"


timer10: String
timer10 =
    "timer_10"


dirtyLens: String
dirtyLens =
    "dirty_lens"


wbShade: String
wbShade =
    "wb_shade"


noFlash: String
noFlash =
    "no_flash"


filter6: String
filter6 =
    "filter_6"


trailLength: String
trailLength =
    "trail_length"


imageAspectRatio: String
imageAspectRatio =
    "image_aspect_ratio"


exposureNeg2: String
exposureNeg2 =
    "exposure_neg_2"


vignette: String
vignette =
    "vignette"


timer3: String
timer3 =
    "timer_3"


leakRemove: String
leakRemove =
    "leak_remove"


i60fpsSelect: String
i60fpsSelect =
    "60fps_select"


blurOff: String
blurOff =
    "blur_off"


i30fpsSelect: String
i30fpsSelect =
    "30fps_select"


permCameraMic: String
permCameraMic =
    "perm_camera_mic"


micExternalOff: String
micExternalOff =
    "mic_external_off"


trailLengthMedium: String
trailLengthMedium =
    "trail_length_medium"


cameraRear: String
cameraRear =
    "camera_rear"


panoramaVertical: String
panoramaVertical =
    "panorama_vertical"


trailLengthShort: String
trailLengthShort =
    "trail_length_short"


autofpsSelect: String
autofpsSelect =
    "autofps_select"


nightSightAutoOff: String
nightSightAutoOff =
    "night_sight_auto_off"


autoFixHigh: String
autoFixHigh =
    "auto_fix_high"


panoramaWideAngle: String
panoramaWideAngle =
    "panorama_wide_angle"


mp: String
mp =
    "mp"


hdrOff: String
hdrOff =
    "hdr_off"


hdrOnSelect: String
hdrOnSelect =
    "hdr_on_select"


i24mp: String
i24mp =
    "24mp"


hdrEnhancedSelect: String
hdrEnhancedSelect =
    "hdr_enhanced_select"


i22mp: String
i22mp =
    "22mp"


astrophotographyOff: String
astrophotographyOff =
    "astrophotography_off"


autoFixNormal: String
autoFixNormal =
    "auto_fix_normal"


i10mp: String
i10mp =
    "10mp"


i12mp: String
i12mp =
    "12mp"


i18mp: String
i18mp =
    "18mp"


wbAuto: String
wbAuto =
    "wb_auto"


hdrAutoSelect: String
hdrAutoSelect =
    "hdr_auto_select"


rawOff: String
rawOff =
    "raw_off"


i9mp: String
i9mp =
    "9mp"


hdrPlus: String
hdrPlus =
    "hdr_plus"


i13mp: String
i13mp =
    "13mp"


i7mp: String
i7mp =
    "7mp"


i15mp: String
i15mp =
    "15mp"


hdrOffSelect: String
hdrOffSelect =
    "hdr_off_select"


i20mp: String
i20mp =
    "20mp"


hevc: String
hevc =
    "hevc"


i16mp: String
i16mp =
    "16mp"


i19mp: String
i19mp =
    "19mp"


i14mp: String
i14mp =
    "14mp"


i23mp: String
i23mp =
    "23mp"


i2mp: String
i2mp =
    "2mp"


i8mp: String
i8mp =
    "8mp"


i3mp: String
i3mp =
    "3mp"


i5mp: String
i5mp =
    "5mp"


i6mp: String
i6mp =
    "6mp"


i11mp: String
i11mp =
    "11mp"


i21mp: String
i21mp =
    "21mp"


i17mp: String
i17mp =
    "17mp"


i4mp: String
i4mp =
    "4mp"


autoFixOff: String
autoFixOff =
    "auto_fix_off"


galleryThumbnail: String
galleryThumbnail =
    "gallery_thumbnail"


settingsPanorama: String
settingsPanorama =
    "settings_panorama"


settingsPhotoCamera: String
settingsPhotoCamera =
    "settings_photo_camera"


motionMode: String
motionMode =
    "motion_mode"


settingsMotionMode: String
settingsMotionMode =
    "settings_motion_mode"


settingsNightSight: String
settingsNightSight =
    "settings_night_sight"


backgroundDotLarge: String
backgroundDotLarge =
    "background_dot_large"


i50mp: String
i50mp =
    "50mp"


settingsVideoCamera: String
settingsVideoCamera =
    "settings_video_camera"


backgroundGridSmall: String
backgroundGridSmall =
    "background_grid_small"


lowDensity: String
lowDensity =
    "low_density"


macroAuto: String
macroAuto =
    "macro_auto"


highDensity: String
highDensity =
    "high_density"


settingsBRoll: String
settingsBRoll =
    "settings_b_roll"


settingsCinematicBlur: String
settingsCinematicBlur =
    "settings_cinematic_blur"


settingsSlowMotion: String
settingsSlowMotion =
    "settings_slow_motion"


settingsTimelapse: String
settingsTimelapse =
    "settings_timelapse"


shoppingCart: String
shoppingCart =
    "shopping_cart"


payments: String
payments =
    "payments"


shoppingBag: String
shoppingBag =
    "shopping_bag"


monitoring: String
monitoring =
    "monitoring"


creditCard: String
creditCard =
    "credit_card"


receiptLong: String
receiptLong =
    "receipt_long"


attachMoney: String
attachMoney =
    "attach_money"


storefront: String
storefront =
    "storefront"


sell: String
sell =
    "sell"


trendingUp: String
trendingUp =
    "trending_up"


database: String
database =
    "database"


accountBalance: String
accountBalance =
    "account_balance"


work: String
work =
    "work"


paid: String
paid =
    "paid"


accountBalanceWallet: String
accountBalanceWallet =
    "account_balance_wallet"


analytics: String
analytics =
    "analytics"


insights: String
insights =
    "insights"


queryStats: String
queryStats =
    "query_stats"


store: String
store =
    "store"


savings: String
savings =
    "savings"


monetizationOn: String
monetizationOn =
    "monetization_on"


calculate: String
calculate =
    "calculate"


qrCodeScanner: String
qrCodeScanner =
    "qr_code_scanner"


barChart: String
barChart =
    "bar_chart"


addShoppingCart: String
addShoppingCart =
    "add_shopping_cart"


accountTree: String
accountTree =
    "account_tree"


receipt: String
receipt =
    "receipt"


redeem: String
redeem =
    "redeem"


currencyExchange: String
currencyExchange =
    "currency_exchange"


trendingFlat: String
trendingFlat =
    "trending_flat"


shoppingBasket: String
shoppingBasket =
    "shopping_basket"


qrCode2: String
qrCode2 =
    "qr_code_2"


domain: String
domain =
    "domain"


qrCode: String
qrCode =
    "qr_code"


precisionManufacturing: String
precisionManufacturing =
    "precision_manufacturing"


leaderboard: String
leaderboard =
    "leaderboard"


corporateFare: String
corporateFare =
    "corporate_fare"


timeline: String
timeline =
    "timeline"


currencyRupee: String
currencyRupee =
    "currency_rupee"


insertChart: String
insertChart =
    "insert_chart"


wallet: String
wallet =
    "wallet"


showChart: String
showChart =
    "show_chart"


euro: String
euro =
    "euro"


workHistory: String
workHistory =
    "work_history"


meetingRoom: String
meetingRoom =
    "meeting_room"


creditScore: String
creditScore =
    "credit_score"


barcodeScanner: String
barcodeScanner =
    "barcode_scanner"


pieChart: String
pieChart =
    "pie_chart"


loyalty: String
loyalty =
    "loyalty"


copyright: String
copyright =
    "copyright"


barcode: String
barcode =
    "barcode"


conversionPath: String
conversionPath =
    "conversion_path"


trackChanges: String
trackChanges =
    "track_changes"


autoGraph: String
autoGraph =
    "auto_graph"


trendingDown: String
trendingDown =
    "trending_down"


priceCheck: String
priceCheck =
    "price_check"


euroSymbol: String
euroSymbol =
    "euro_symbol"


schema: String
schema =
    "schema"


addBusiness: String
addBusiness =
    "add_business"


addCard: String
addCard =
    "add_card"


cardMembership: String
cardMembership =
    "card_membership"


currencyBitcoin: String
currencyBitcoin =
    "currency_bitcoin"


priceChange: String
priceChange =
    "price_change"


productionQuantityLimits: String
productionQuantityLimits =
    "production_quantity_limits"


donutLarge: String
donutLarge =
    "donut_large"


tenancy: String
tenancy =
    "tenancy"


dataExploration: String
dataExploration =
    "data_exploration"


bubbleChart: String
bubbleChart =
    "bubble_chart"


donutSmall: String
donutSmall =
    "donut_small"


contactless: String
contactless =
    "contactless"


money: String
money =
    "money"


stackedLineChart: String
stackedLineChart =
    "stacked_line_chart"


stackedBarChart: String
stackedBarChart =
    "stacked_bar_chart"


toll: String
toll =
    "toll"


moneyOff: String
moneyOff =
    "money_off"


cases: String
cases =
    "cases"


currencyYen: String
currencyYen =
    "currency_yen"


currencyPound: String
currencyPound =
    "currency_pound"


areaChart: String
areaChart =
    "area_chart"


atr: String
atr =
    "atr"


removeShoppingCart: String
removeShoppingCart =
    "remove_shopping_cart"


roomPreferences: String
roomPreferences =
    "room_preferences"


addChart: String
addChart =
    "add_chart"


shop: String
shop =
    "shop"


domainAdd: String
domainAdd =
    "domain_add"


cardTravel: String
cardTravel =
    "card_travel"


groupedBarChart: String
groupedBarChart =
    "grouped_bar_chart"


legendToggle: String
legendToggle =
    "legend_toggle"


scatterPlot: String
scatterPlot =
    "scatter_plot"


creditCardOff: String
creditCardOff =
    "credit_card_off"


ssidChart: String
ssidChart =
    "ssid_chart"


mediation: String
mediation =
    "mediation"


candlestickChart: String
candlestickChart =
    "candlestick_chart"


currencyRuble: String
currencyRuble =
    "currency_ruble"


waterfallChart: String
waterfallChart =
    "waterfall_chart"


fullStackedBarChart: String
fullStackedBarChart =
    "full_stacked_bar_chart"


domainDisabled: String
domainDisabled =
    "domain_disabled"


strikethroughS: String
strikethroughS =
    "strikethrough_s"


shopTwo: String
shopTwo =
    "shop_two"


nextWeek: String
nextWeek =
    "next_week"


atm: String
atm =
    "atm"


multilineChart: String
multilineChart =
    "multiline_chart"


currencyLira: String
currencyLira =
    "currency_lira"


currencyYuan: String
currencyYuan =
    "currency_yuan"


noMeetingRoom: String
noMeetingRoom =
    "no_meeting_room"


currencyFranc: String
currencyFranc =
    "currency_franc"


autopay: String
autopay =
    "autopay"


contactlessOff: String
contactlessOff =
    "contactless_off"


podium: String
podium =
    "podium"


chartData: String
chartData =
    "chart_data"


orderApprove: String
orderApprove =
    "order_approve"


familyHistory: String
familyHistory =
    "family_history"


conveyorBelt: String
conveyorBelt =
    "conveyor_belt"


flowsheet: String
flowsheet =
    "flowsheet"


autoMeetingRoom: String
autoMeetingRoom =
    "auto_meeting_room"


barChart4Bars: String
barChart4Bars =
    "bar_chart_4_bars"


forklift: String
forklift =
    "forklift"


frontLoader: String
frontLoader =
    "front_loader"


pallet: String
pallet =
    "pallet"


inactiveOrder: String
inactiveOrder =
    "inactive_order"


qrCode2Add: String
qrCode2Add =
    "qr_code_2_add"


barcodeReader: String
barcodeReader =
    "barcode_reader"


conversionPathOff: String
conversionPathOff =
    "conversion_path_off"


trolley: String
trolley =
    "trolley"


orderPlay: String
orderPlay =
    "order_play"


pinDrop: String
pinDrop =
    "pin_drop"


locationOn: String
locationOn =
    "location_on"


map: String
map =
    "map"


homePin: String
homePin =
    "home_pin"


explore: String
explore =
    "explore"


restaurant: String
restaurant =
    "restaurant"


flag: String
flag =
    "flag"


myLocation: String
myLocation =
    "my_location"


localFireDepartment: String
localFireDepartment =
    "local_fire_department"


personPinCircle: String
personPinCircle =
    "person_pin_circle"


localMall: String
localMall =
    "local_mall"


nearMe: String
nearMe =
    "near_me"


whereToVote: String
whereToVote =
    "where_to_vote"


businessCenter: String
businessCenter =
    "business_center"


east: String
east =
    "east"


restaurantMenu: String
restaurantMenu =
    "restaurant_menu"


handyman: String
handyman =
    "handyman"


factory: String
factory =
    "factory"


localLibrary: String
localLibrary =
    "local_library"


homeWork: String
homeWork =
    "home_work"


medicalServices: String
medicalServices =
    "medical_services"


layers: String
layers =
    "layers"


localActivity: String
localActivity =
    "local_activity"


shareLocation: String
shareLocation =
    "share_location"


emergency: String
emergency =
    "emergency"


northEast: String
northEast =
    "north_east"


addLocation: String
addLocation =
    "add_location"


fastfood: String
fastfood =
    "fastfood"


warehouse: String
warehouse =
    "warehouse"


navigation: String
navigation =
    "navigation"


personPin: String
personPin =
    "person_pin"


localParking: String
localParking =
    "local_parking"


homeRepairService: String
homeRepairService =
    "home_repair_service"


localHospital: String
localHospital =
    "local_hospital"


south: String
south =
    "south"


localPolice: String
localPolice =
    "local_police"


zoomOutMap: String
zoomOutMap =
    "zoom_out_map"


locationSearching: String
locationSearching =
    "location_searching"


localFlorist: String
localFlorist =
    "local_florist"


locationAway: String
locationAway =
    "location_away"


crisisAlert: String
crisisAlert =
    "crisis_alert"


west: String
west =
    "west"


localGasStation: String
localGasStation =
    "local_gas_station"


park: String
park =
    "park"


mapsUgc: String
mapsUgc =
    "maps_ugc"


cleaningServices: String
cleaningServices =
    "cleaning_services"


package: String
package =
    "package"


localAtm: String
localAtm =
    "local_atm"


i360: String
i360 =
    "360"


electricalServices: String
electricalServices =
    "electrical_services"


north: String
north =
    "north"


flagCircle: String
flagCircle =
    "flag_circle"


addLocationAlt: String
addLocationAlt =
    "add_location_alt"


directions: String
directions =
    "directions"


fmdBad: String
fmdBad =
    "fmd_bad"


theaterComedy: String
theaterComedy =
    "theater_comedy"


localDrink: String
localDrink =
    "local_drink"


locationHome: String
locationHome =
    "location_home"


localPizza: String
localPizza =
    "local_pizza"


localPostOffice: String
localPostOffice =
    "local_post_office"


notListedLocation: String
notListedLocation =
    "not_listed_location"


wineBar: String
wineBar =
    "wine_bar"


beenhere: String
beenhere =
    "beenhere"


localConvenienceStore: String
localConvenienceStore =
    "local_convenience_store"


signpost: String
signpost =
    "signpost"


altRoute: String
altRoute =
    "alt_route"


locationAutomation: String
locationAutomation =
    "location_automation"


tour: String
tour =
    "tour"


church: String
church =
    "church"


tripOrigin: String
tripOrigin =
    "trip_origin"


traffic: String
traffic =
    "traffic"


localLaundryService: String
localLaundryService =
    "local_laundry_service"


safetyCheck: String
safetyCheck =
    "safety_check"


evStation: String
evStation =
    "ev_station"


takeoutDining: String
takeoutDining =
    "takeout_dining"


moving: String
moving =
    "moving"


zoomInMap: String
zoomInMap =
    "zoom_in_map"


soupKitchen: String
soupKitchen =
    "soup_kitchen"


stadium: String
stadium =
    "stadium"


transferWithinAStation: String
transferWithinAStation =
    "transfer_within_a_station"


locationOff: String
locationOff =
    "location_off"


pestControl: String
pestControl =
    "pest_control"


connectingAirports: String
connectingAirports =
    "connecting_airports"


multipleStop: String
multipleStop =
    "multiple_stop"


wrongLocation: String
wrongLocation =
    "wrong_location"


editLocation: String
editLocation =
    "edit_location"


plumbing: String
plumbing =
    "plumbing"


modeOfTravel: String
modeOfTravel =
    "mode_of_travel"


minorCrash: String
minorCrash =
    "minor_crash"


southEast: String
southEast =
    "south_east"


localPharmacy: String
localPharmacy =
    "local_pharmacy"


addRoad: String
addRoad =
    "add_road"


fireTruck: String
fireTruck =
    "fire_truck"


castle: String
castle =
    "castle"


dryCleaning: String
dryCleaning =
    "dry_cleaning"


setMeal: String
setMeal =
    "set_meal"


babyChangingStation: String
babyChangingStation =
    "baby_changing_station"


layersClear: String
layersClear =
    "layers_clear"


editLocationAlt: String
editLocationAlt =
    "edit_location_alt"


mosque: String
mosque =
    "mosque"


northWest: String
northWest =
    "north_west"


localCarWash: String
localCarWash =
    "local_car_wash"


editAttributes: String
editAttributes =
    "edit_attributes"


runCircle: String
runCircle =
    "run_circle"


transitEnterexit: String
transitEnterexit =
    "transit_enterexit"


satellite: String
satellite =
    "satellite"


sos: String
sos =
    "sos"


editRoad: String
editRoad =
    "edit_road"


southWest: String
southWest =
    "south_west"


addHome: String
addHome =
    "add_home"


streetview: String
streetview =
    "streetview"


kebabDining: String
kebabDining =
    "kebab_dining"


airlineStops: String
airlineStops =
    "airline_stops"


fireHydrant: String
fireHydrant =
    "fire_hydrant"


localSee: String
localSee =
    "local_see"


assistWalker: String
assistWalker =
    "assist_walker"


addHomeWork: String
addHomeWork =
    "add_home_work"


flightClass: String
flightClass =
    "flight_class"


noMeals: String
noMeals =
    "no_meals"


removeRoad: String
removeRoad =
    "remove_road"


synagogue: String
synagogue =
    "synagogue"


fort: String
fort =
    "fort"


templeBuddhist: String
templeBuddhist =
    "temple_buddhist"


locationDisabled: String
locationDisabled =
    "location_disabled"


compassCalibration: String
compassCalibration =
    "compass_calibration"


templeHindu: String
templeHindu =
    "temple_hindu"


exploreOff: String
exploreOff =
    "explore_off"


pestControlRodent: String
pestControlRodent =
    "pest_control_rodent"


nearMeDisabled: String
nearMeDisabled =
    "near_me_disabled"


directionsAlt: String
directionsAlt =
    "directions_alt"


pergola: String
pergola =
    "pergola"


directionsOff: String
directionsOff =
    "directions_off"


directionsAltOff: String
directionsAltOff =
    "directions_alt_off"


moveLocation: String
moveLocation =
    "move_location"


movingMinistry: String
movingMinistry =
    "moving_ministry"


move: String
move =
    "move"


description: String
description =
    "description"


contentCopy: String
contentCopy =
    "content_copy"


dashboard: String
dashboard =
    "dashboard"


editNote: String
editNote =
    "edit_note"


menuBook: String
menuBook =
    "menu_book"


gridView: String
gridView =
    "grid_view"


list: String
list =
    "list"


folder: String
folder =
    "folder"


listAlt: String
listAlt =
    "list_alt"


inventory: String
inventory =
    "inventory"


folderOpen: String
folderOpen =
    "folder_open"


article: String
article =
    "article"


factCheck: String
factCheck =
    "fact_check"


attachFile: String
attachFile =
    "attach_file"


formatListBulleted: String
formatListBulleted =
    "format_list_bulleted"


assignment: String
assignment =
    "assignment"


task: String
task =
    "task"


checklist: String
checklist =
    "checklist"


cloudUpload: String
cloudUpload =
    "cloud_upload"


draft: String
draft =
    "draft"


summarize: String
summarize =
    "summarize"


feed: String
feed =
    "feed"


draw: String
draw =
    "draw"


cloud: String
cloud =
    "cloud"


newspaper: String
newspaper =
    "newspaper"


fileCopy: String
fileCopy =
    "file_copy"


viewList: String
viewList =
    "view_list"


noteAdd: String
noteAdd =
    "note_add"


borderColor: String
borderColor =
    "border_color"


book: String
book =
    "book"


historyEdu: String
historyEdu =
    "history_edu"


designServices: String
designServices =
    "design_services"


pendingActions: String
pendingActions =
    "pending_actions"


formatQuote: String
formatQuote =
    "format_quote"


postAdd: String
postAdd =
    "post_add"


requestQuote: String
requestQuote =
    "request_quote"


cloudDownload: String
cloudDownload =
    "cloud_download"


dragHandle: String
dragHandle =
    "drag_handle"


contactPage: String
contactPage =
    "contact_page"


table: String
table =
    "table"


spaceDashboard: String
spaceDashboard =
    "space_dashboard"


archive: String
archive =
    "archive"


contentPaste: String
contentPaste =
    "content_paste"


percent: String
percent =
    "percent"


attachment: String
attachment =
    "attachment"


assignmentInd: String
assignmentInd =
    "assignment_ind"


formatListNumbered: String
formatListNumbered =
    "format_list_numbered"


assignmentTurnedIn: String
assignmentTurnedIn =
    "assignment_turned_in"


tag: String
tag =
    "tag"


tableChart: String
tableChart =
    "table_chart"


stickyNote2: String
stickyNote2 =
    "sticky_note_2"


dashboardCustomize: String
dashboardCustomize =
    "dashboard_customize"


textFields: String
textFields =
    "text_fields"


reorder: String
reorder =
    "reorder"


formatBold: String
formatBold =
    "format_bold"


integrationInstructions: String
integrationInstructions =
    "integration_instructions"


findInPage: String
findInPage =
    "find_in_page"


note: String
note =
    "note"


textSnippet: String
textSnippet =
    "text_snippet"


documentScanner: String
documentScanner =
    "document_scanner"


checklistRtl: String
checklistRtl =
    "checklist_rtl"


noteAlt: String
noteAlt =
    "note_alt"


cloudSync: String
cloudSync =
    "cloud_sync"


editDocument: String
editDocument =
    "edit_document"


tableRows: String
tableRows =
    "table_rows"


permMedia: String
permMedia =
    "perm_media"


cloudDone: String
cloudDone =
    "cloud_done"


title: String
title =
    "title"


tableView: String
tableView =
    "table_view"


contentCut: String
contentCut =
    "content_cut"


dataObject: String
dataObject =
    "data_object"


cut: String
cut =
    "cut"


notes: String
notes =
    "notes"


subject: String
subject =
    "subject"


functions: String
functions =
    "functions"


formatItalic: String
formatItalic =
    "format_italic"


contentPasteSearch: String
contentPasteSearch =
    "content_paste_search"


formatColorFill: String
formatColorFill =
    "format_color_fill"


folderShared: String
folderShared =
    "folder_shared"


plagiarism: String
plagiarism =
    "plagiarism"


horizontalRule: String
horizontalRule =
    "horizontal_rule"


filePresent: String
filePresent =
    "file_present"


folderCopy: String
folderCopy =
    "folder_copy"


formatAlignLeft: String
formatAlignLeft =
    "format_align_left"


ballot: String
ballot =
    "ballot"


teamDashboard: String
teamDashboard =
    "team_dashboard"


formatPaint: String
formatPaint =
    "format_paint"


addLink: String
addLink =
    "add_link"


cloudOff: String
cloudOff =
    "cloud_off"


readMore: String
readMore =
    "read_more"


viewColumn: String
viewColumn =
    "view_column"


difference: String
difference =
    "difference"


viewAgenda: String
viewAgenda =
    "view_agenda"


formatSize: String
formatSize =
    "format_size"


formatUnderlined: String
formatUnderlined =
    "format_underlined"


verticalAlignTop: String
verticalAlignTop =
    "vertical_align_top"


toc: String
toc =
    "toc"


height: String
height =
    "height"


verticalAlignBottom: String
verticalAlignBottom =
    "vertical_align_bottom"


copyAll: String
copyAll =
    "copy_all"


driveFolderUpload: String
driveFolderUpload =
    "drive_folder_upload"


viewWeek: String
viewWeek =
    "view_week"


formatColorText: String
formatColorText =
    "format_color_text"


assignmentLate: String
assignmentLate =
    "assignment_late"


viewModule: String
viewModule =
    "view_module"


driveFileMove: String
driveFileMove =
    "drive_file_move"


assignmentReturn: String
assignmentReturn =
    "assignment_return"


lowPriority: String
lowPriority =
    "low_priority"


formatAlignCenter: String
formatAlignCenter =
    "format_align_center"


folderSpecial: String
folderSpecial =
    "folder_special"


segment: String
segment =
    "segment"


calendarViewMonth: String
calendarViewMonth =
    "calendar_view_month"


polyline: String
polyline =
    "polyline"


folderZip: String
folderZip =
    "folder_zip"


square: String
square =
    "square"


breakingNewsAlt1: String
breakingNewsAlt1 =
    "breaking_news_alt_1"


formatAlignRight: String
formatAlignRight =
    "format_align_right"


grading: String
grading =
    "grading"


viewHeadline: String
viewHeadline =
    "view_headline"


linearScale: String
linearScale =
    "linear_scale"


viewQuilt: String
viewQuilt =
    "view_quilt"


editOff: String
editOff =
    "edit_off"


viewCarousel: String
viewCarousel =
    "view_carousel"


textIncrease: String
textIncrease =
    "text_increase"


requestPage: String
requestPage =
    "request_page"


viewSidebar: String
viewSidebar =
    "view_sidebar"


pages: String
pages =
    "pages"


textFormat: String
textFormat =
    "text_format"


formatAlignJustify: String
formatAlignJustify =
    "format_align_justify"


calendarViewWeek: String
calendarViewWeek =
    "calendar_view_week"


hexagon: String
hexagon =
    "hexagon"


numbers: String
numbers =
    "numbers"


docsAddOn: String
docsAddOn =
    "docs_add_on"


folderDelete: String
folderDelete =
    "folder_delete"


formatShapes: String
formatShapes =
    "format_shapes"


formsAddOn: String
formsAddOn =
    "forms_add_on"


imagesearchRoller: String
imagesearchRoller =
    "imagesearch_roller"


joinFull: String
joinFull =
    "join_full"


calendarViewDay: String
calendarViewDay =
    "calendar_view_day"


videoFile: String
videoFile =
    "video_file"


cloudQueue: String
cloudQueue =
    "cloud_queue"


formatListNumberedRtl: String
formatListNumberedRtl =
    "format_list_numbered_rtl"


fontDownload: String
fontDownload =
    "font_download"


joinInner: String
joinInner =
    "join_inner"


addToDrive: String
addToDrive =
    "add_to_drive"


contentPasteGo: String
contentPasteGo =
    "content_paste_go"


restorePage: String
restorePage =
    "restore_page"


rectangle: String
rectangle =
    "rectangle"


verticalSplit: String
verticalSplit =
    "vertical_split"


formatColorReset: String
formatColorReset =
    "format_color_reset"


ruleFolder: String
ruleFolder =
    "rule_folder"


viewStream: String
viewStream =
    "view_stream"


cloudCircle: String
cloudCircle =
    "cloud_circle"


formatIndentIncrease: String
formatIndentIncrease =
    "format_indent_increase"


spellcheck: String
spellcheck =
    "spellcheck"


assignmentReturned: String
assignmentReturned =
    "assignment_returned"


dataArray: String
dataArray =
    "data_array"


alignHorizontalLeft: String
alignHorizontalLeft =
    "align_horizontal_left"


pivotTableChart: String
pivotTableChart =
    "pivot_table_chart"


textDecrease: String
textDecrease =
    "text_decrease"


deselect: String
deselect =
    "deselect"


verticalAlignCenter: String
verticalAlignCenter =
    "vertical_align_center"


pentagon: String
pentagon =
    "pentagon"


spaceBar: String
spaceBar =
    "space_bar"


mergeType: String
mergeType =
    "merge_type"


viewDay: String
viewDay =
    "view_day"


formatStrikethrough: String
formatStrikethrough =
    "format_strikethrough"


flipToFront: String
flipToFront =
    "flip_to_front"


joinLeft: String
joinLeft =
    "join_left"


borderAll: String
borderAll =
    "border_all"


shortText: String
shortText =
    "short_text"


shapeLine: String
shapeLine =
    "shape_line"


formatLineSpacing: String
formatLineSpacing =
    "format_line_spacing"


lineWeight: String
lineWeight =
    "line_weight"


horizontalSplit: String
horizontalSplit =
    "horizontal_split"


formatIndentDecrease: String
formatIndentDecrease =
    "format_indent_decrease"


alignHorizontalCenter: String
alignHorizontalCenter =
    "align_horizontal_center"


joinRight: String
joinRight =
    "join_right"


snippetFolder: String
snippetFolder =
    "snippet_folder"


subtitlesOff: String
subtitlesOff =
    "subtitles_off"


alignVerticalBottom: String
alignVerticalBottom =
    "align_vertical_bottom"


folderOff: String
folderOff =
    "folder_off"


alignHorizontalRight: String
alignHorizontalRight =
    "align_horizontal_right"


glyphs: String
glyphs =
    "glyphs"


formatClear: String
formatClear =
    "format_clear"


insertPageBreak: String
insertPageBreak =
    "insert_page_break"


contentPasteOff: String
contentPasteOff =
    "content_paste_off"


verticalDistribute: String
verticalDistribute =
    "vertical_distribute"


function: String
function =
    "function"


superscript: String
superscript =
    "superscript"


horizontalDistribute: String
horizontalDistribute =
    "horizontal_distribute"


lineAxis: String
lineAxis =
    "line_axis"


lineStyle: String
lineStyle =
    "line_style"


flipToBack: String
flipToBack =
    "flip_to_back"


alignVerticalCenter: String
alignVerticalCenter =
    "align_vertical_center"


alignVerticalTop: String
alignVerticalTop =
    "align_vertical_top"


margin: String
margin =
    "margin"


clarify: String
clarify =
    "clarify"


wrapText: String
wrapText =
    "wrap_text"


viewArray: String
viewArray =
    "view_array"


subscript: String
subscript =
    "subscript"


borderClear: String
borderClear =
    "border_clear"


borderStyle: String
borderStyle =
    "border_style"


borderOuter: String
borderOuter =
    "border_outer"


ampStories: String
ampStories =
    "amp_stories"


typeSpecimen: String
typeSpecimen =
    "type_specimen"


textRotateVertical: String
textRotateVertical =
    "text_rotate_vertical"


padding: String
padding =
    "padding"


formsAppsScript: String
formsAppsScript =
    "forms_apps_script"


borderVertical: String
borderVertical =
    "border_vertical"


textRotationNone: String
textRotationNone =
    "text_rotation_none"


formatTextdirectionLToR: String
formatTextdirectionLToR =
    "format_textdirection_l_to_r"


formatOverline: String
formatOverline =
    "format_overline"


docsAppsScript: String
docsAppsScript =
    "docs_apps_script"


borderHorizontal: String
borderHorizontal =
    "border_horizontal"


fontDownloadOff: String
fontDownloadOff =
    "font_download_off"


formatTextdirectionRToL: String
formatTextdirectionRToL =
    "format_textdirection_r_to_l"


textRotationAngleup: String
textRotationAngleup =
    "text_rotation_angleup"


borderBottom: String
borderBottom =
    "border_bottom"


borderTop: String
borderTop =
    "border_top"


textRotationDown: String
textRotationDown =
    "text_rotation_down"


borderLeft: String
borderLeft =
    "border_left"


textRotationAngledown: String
textRotationAngledown =
    "text_rotation_angledown"


borderInner: String
borderInner =
    "border_inner"


textRotateUp: String
textRotateUp =
    "text_rotate_up"


borderRight: String
borderRight =
    "border_right"


formatH1: String
formatH1 =
    "format_h1"


assignmentAdd: String
assignmentAdd =
    "assignment_add"


financeChip: String
financeChip =
    "finance_chip"


viewColumn2: String
viewColumn2 =
    "view_column_2"


join: String
join =
    "join"


formatUnderlinedSquiggle: String
formatUnderlinedSquiggle =
    "format_underlined_squiggle"


counter1: String
counter1 =
    "counter_1"


formatH2: String
formatH2 =
    "format_h2"


formatParagraph: String
formatParagraph =
    "format_paragraph"


formatImageLeft: String
formatImageLeft =
    "format_image_left"


overview: String
overview =
    "overview"


slideLibrary: String
slideLibrary =
    "slide_library"


formatListBulletedAdd: String
formatListBulletedAdd =
    "format_list_bulleted_add"


formatH3: String
formatH3 =
    "format_h3"


formatImageRight: String
formatImageRight =
    "format_image_right"


formatH5: String
formatH5 =
    "format_h5"


formatH6: String
formatH6 =
    "format_h6"


variables: String
variables =
    "variables"


frameInspect: String
frameInspect =
    "frame_inspect"


formatH4: String
formatH4 =
    "format_h4"


processChart: String
processChart =
    "process_chart"


votingChip: String
votingChip =
    "voting_chip"


locationChip: String
locationChip =
    "location_chip"


counter2: String
counter2 =
    "counter_2"


labProfile: String
labProfile =
    "lab_profile"


formatInkHighlighter: String
formatInkHighlighter =
    "format_ink_highlighter"


counter3: String
counter3 =
    "counter_3"


equal: String
equal =
    "equal"


signature: String
signature =
    "signature"


businessChip: String
businessChip =
    "business_chip"


exportNotes: String
exportNotes =
    "export_notes"


shapes: String
shapes =
    "shapes"


addNotes: String
addNotes =
    "add_notes"


cellMerge: String
cellMerge =
    "cell_merge"


counter4: String
counter4 =
    "counter_4"


textSelectMoveForwardCharacter: String
textSelectMoveForwardCharacter =
    "text_select_move_forward_character"


diagnosis: String
diagnosis =
    "diagnosis"


listAltAdd: String
listAltAdd =
    "list_alt_add"


tableRowsNarrow: String
tableRowsNarrow =
    "table_rows_narrow"


unknownDocument: String
unknownDocument =
    "unknown_document"


decimalIncrease: String
decimalIncrease =
    "decimal_increase"


frameSource: String
frameSource =
    "frame_source"


insertText: String
insertText =
    "insert_text"


regularExpression: String
regularExpression =
    "regular_expression"


resetImage: String
resetImage =
    "reset_image"


lineEndArrowNotch: String
lineEndArrowNotch =
    "line_end_arrow_notch"


lineStart: String
lineStart =
    "line_start"


stylusLaserPointer: String
stylusLaserPointer =
    "stylus_laser_pointer"


tableChartView: String
tableChartView =
    "table_chart_view"


formatLetterSpacing: String
formatLetterSpacing =
    "format_letter_spacing"


lineEnd: String
lineEnd =
    "line_end"


gridGuides: String
gridGuides =
    "grid_guides"


lineEndSquare: String
lineEndSquare =
    "line_end_square"


scanDelete: String
scanDelete =
    "scan_delete"


ungroup: String
ungroup =
    "ungroup"


matchCase: String
matchCase =
    "match_case"


scan: String
scan =
    "scan"


alignJustifySpaceBetween: String
alignJustifySpaceBetween =
    "align_justify_space_between"


counter5: String
counter5 =
    "counter_5"


counter6: String
counter6 =
    "counter_6"


languageChineseQuick: String
languageChineseQuick =
    "language_chinese_quick"


lineEndArrow: String
lineEndArrow =
    "line_end_arrow"


otherAdmission: String
otherAdmission =
    "other_admission"


sourceNotes: String
sourceNotes =
    "source_notes"


strokeFull: String
strokeFull =
    "stroke_full"


drawCollage: String
drawCollage =
    "draw_collage"


folderSupervised: String
folderSupervised =
    "folder_supervised"


lineEndCircle: String
lineEndCircle =
    "line_end_circle"


lineEndDiamond: String
lineEndDiamond =
    "line_end_diamond"


lineStartCircle: String
lineStartCircle =
    "line_start_circle"


sheetsRtl: String
sheetsRtl =
    "sheets_rtl"


tabClose: String
tabClose =
    "tab_close"


tabMove: String
tabMove =
    "tab_move"


textSelectJumpToBeginning: String
textSelectJumpToBeginning =
    "text_select_jump_to_beginning"


topPanelOpen: String
topPanelOpen =
    "top_panel_open"


width: String
width =
    "width"


alignJustifySpaceAround: String
alignJustifySpaceAround =
    "align_justify_space_around"


alignJustifySpaceEven: String
alignJustifySpaceEven =
    "align_justify_space_even"


alignSpaceBetween: String
alignSpaceBetween =
    "align_space_between"


drawAbstract: String
drawAbstract =
    "draw_abstract"


folderManaged: String
folderManaged =
    "folder_managed"


frameReload: String
frameReload =
    "frame_reload"


lineStartSquare: String
lineStartSquare =
    "line_start_square"


matchWord: String
matchWord =
    "match_word"


select: String
select =
    "select"


smbShare: String
smbShare =
    "smb_share"


tabNewRight: String
tabNewRight =
    "tab_new_right"


textSelectMoveForwardWord: String
textSelectMoveForwardWord =
    "text_select_move_forward_word"


textSelectStart: String
textSelectStart =
    "text_select_start"


thumbnailBar: String
thumbnailBar =
    "thumbnail_bar"


topPanelClose: String
topPanelClose =
    "top_panel_close"


alignJustifyCenter: String
alignJustifyCenter =
    "align_justify_center"


alignJustifyFlexEnd: String
alignJustifyFlexEnd =
    "align_justify_flex_end"


alignJustifyFlexStart: String
alignJustifyFlexStart =
    "align_justify_flex_start"


alignSpaceAround: String
alignSpaceAround =
    "align_space_around"


alignSpaceEven: String
alignSpaceEven =
    "align_space_even"


attachFileAdd: String
attachFileAdd =
    "attach_file_add"


counter7: String
counter7 =
    "counter_7"


counter8: String
counter8 =
    "counter_8"


fitPage: String
fitPage =
    "fit_page"


fitWidth: String
fitWidth =
    "fit_width"


formatTextOverflow: String
formatTextOverflow =
    "format_text_overflow"


formatTextWrap: String
formatTextWrap =
    "format_text_wrap"


heapSnapshotThumbnail: String
heapSnapshotThumbnail =
    "heap_snapshot_thumbnail"


highlighterSize4: String
highlighterSize4 =
    "highlighter_size_4"


languageChineseDayi: String
languageChineseDayi =
    "language_chinese_dayi"


languageChinesePinyin: String
languageChinesePinyin =
    "language_chinese_pinyin"


languageChineseWubi: String
languageChineseWubi =
    "language_chinese_wubi"


languageGbEnglish: String
languageGbEnglish =
    "language_gb_english"


languageKoreanLatin: String
languageKoreanLatin =
    "language_korean_latin"


languageUs: String
languageUs =
    "language_us"


lineCurve: String
lineCurve =
    "line_curve"


penSize2: String
penSize2 =
    "pen_size_2"


penSize5: String
penSize5 =
    "pen_size_5"


strokePartial: String
strokePartial =
    "stroke_partial"


tabCloseRight: String
tabCloseRight =
    "tab_close_right"


tabDuplicate: String
tabDuplicate =
    "tab_duplicate"


textSelectMoveDown: String
textSelectMoveDown =
    "text_select_move_down"


textSelectMoveUp: String
textSelectMoveUp =
    "text_select_move_up"


alignCenter: String
alignCenter =
    "align_center"


alignEnd: String
alignEnd =
    "align_end"


alignFlexCenter: String
alignFlexCenter =
    "align_flex_center"


alignFlexEnd: String
alignFlexEnd =
    "align_flex_end"


alignFlexStart: String
alignFlexStart =
    "align_flex_start"


alignItemsStretch: String
alignItemsStretch =
    "align_items_stretch"


alignJustifyStretch: String
alignJustifyStretch =
    "align_justify_stretch"


alignSelfStretch: String
alignSelfStretch =
    "align_self_stretch"


alignStart: String
alignStart =
    "align_start"


alignStretch: String
alignStretch =
    "align_stretch"


counter0: String
counter0 =
    "counter_0"


counter9: String
counter9 =
    "counter_9"


decimalDecrease: String
decimalDecrease =
    "decimal_decrease"


flexDirection: String
flexDirection =
    "flex_direction"


flexNoWrap: String
flexNoWrap =
    "flex_no_wrap"


flexWrap: String
flexWrap =
    "flex_wrap"


formatLetterSpacing2: String
formatLetterSpacing2 =
    "format_letter_spacing_2"


formatLetterSpacingStandard: String
formatLetterSpacingStandard =
    "format_letter_spacing_standard"


formatLetterSpacingWide: String
formatLetterSpacingWide =
    "format_letter_spacing_wide"


formatLetterSpacingWider: String
formatLetterSpacingWider =
    "format_letter_spacing_wider"


formatTextClip: String
formatTextClip =
    "format_text_clip"


heapSnapshotLarge: String
heapSnapshotLarge =
    "heap_snapshot_large"


heapSnapshotMultiple: String
heapSnapshotMultiple =
    "heap_snapshot_multiple"


highlighterSize1: String
highlighterSize1 =
    "highlighter_size_1"


highlighterSize2: String
highlighterSize2 =
    "highlighter_size_2"


highlighterSize3: String
highlighterSize3 =
    "highlighter_size_3"


highlighterSize5: String
highlighterSize5 =
    "highlighter_size_5"


languageChineseArray: String
languageChineseArray =
    "language_chinese_array"


languageChineseCangjie: String
languageChineseCangjie =
    "language_chinese_cangjie"


languageFrench: String
languageFrench =
    "language_french"


languageInternational: String
languageInternational =
    "language_international"


languagePinyin: String
languagePinyin =
    "language_pinyin"


languageUsColemak: String
languageUsColemak =
    "language_us_colemak"


languageUsDvorak: String
languageUsDvorak =
    "language_us_dvorak"


letterSwitch: String
letterSwitch =
    "letter_switch"


lineStartArrow: String
lineStartArrow =
    "line_start_arrow"


lineStartArrowNotch: String
lineStartArrowNotch =
    "line_start_arrow_notch"


lineStartDiamond: String
lineStartDiamond =
    "line_start_diamond"


penSize1: String
penSize1 =
    "pen_size_1"


penSize3: String
penSize3 =
    "pen_size_3"


penSize4: String
penSize4 =
    "pen_size_4"


specialCharacter: String
specialCharacter =
    "special_character"


tabGroup: String
tabGroup =
    "tab_group"


tabRecent: String
tabRecent =
    "tab_recent"


textSelectEnd: String
textSelectEnd =
    "text_select_end"


textSelectJumpToEnd: String
textSelectJumpToEnd =
    "text_select_jump_to_end"


textSelectMoveBackCharacter: String
textSelectMoveBackCharacter =
    "text_select_move_back_character"


textSelectMoveBackWord: String
textSelectMoveBackWord =
    "text_select_move_back_word"


playArrow: String
playArrow =
    "play_arrow"


playCircle: String
playCircle =
    "play_circle"


mic: String
mic =
    "mic"


videocam: String
videocam =
    "videocam"


volumeUp: String
volumeUp =
    "volume_up"


pause: String
pause =
    "pause"


musicNote: String
musicNote =
    "music_note"


libraryBooks: String
libraryBooks =
    "library_books"


movie: String
movie =
    "movie"


skipNext: String
skipNext =
    "skip_next"


speed: String
speed =
    "speed"


replay: String
replay =
    "replay"


volumeOff: String
volumeOff =
    "volume_off"


viewInAr: String
viewInAr =
    "view_in_ar"


pauseCircle: String
pauseCircle =
    "pause_circle"


fiberManualRecord: String
fiberManualRecord =
    "fiber_manual_record"


skipPrevious: String
skipPrevious =
    "skip_previous"


stopCircle: String
stopCircle =
    "stop_circle"


stop: String
stop =
    "stop"


equalizer: String
equalizer =
    "equalizer"


subscriptions: String
subscriptions =
    "subscriptions"


videoLibrary: String
videoLibrary =
    "video_library"


fastForward: String
fastForward =
    "fast_forward"


playlistAdd: String
playlistAdd =
    "playlist_add"


videoCall: String
videoCall =
    "video_call"


repeat: String
repeat =
    "repeat"


volumeMute: String
volumeMute =
    "volume_mute"


shuffle: String
shuffle =
    "shuffle"


micOff: String
micOff =
    "mic_off"


libraryMusic: String
libraryMusic =
    "library_music"


hearing: String
hearing =
    "hearing"


podcasts: String
podcasts =
    "podcasts"


playlistAddCheck: String
playlistAddCheck =
    "playlist_add_check"


fastRewind: String
fastRewind =
    "fast_rewind"


soundDetectionDogBarking: String
soundDetectionDogBarking =
    "sound_detection_dog_barking"


queueMusic: String
queueMusic =
    "queue_music"


videoCameraFront: String
videoCameraFront =
    "video_camera_front"


subtitles: String
subtitles =
    "subtitles"


volumeDown: String
volumeDown =
    "volume_down"


playPause: String
playPause =
    "play_pause"


album: String
album =
    "album"


radio: String
radio =
    "radio"


avTimer: String
avTimer =
    "av_timer"


discoverTune: String
discoverTune =
    "discover_tune"


libraryAddCheck: String
libraryAddCheck =
    "library_add_check"


videocamOff: String
videocamOff =
    "videocam_off"


closedCaption: String
closedCaption =
    "closed_caption"


stream: String
stream =
    "stream"


forward10: String
forward10 =
    "forward_10"


notStarted: String
notStarted =
    "not_started"


playlistPlay: String
playlistPlay =
    "playlist_play"


replay10: String
replay10 =
    "replay_10"


fiberNew: String
fiberNew =
    "fiber_new"


brandingWatermark: String
brandingWatermark =
    "branding_watermark"


recentActors: String
recentActors =
    "recent_actors"


textToSpeech: String
textToSpeech =
    "text_to_speech"


playlistRemove: String
playlistRemove =
    "playlist_remove"


interpreterMode: String
interpreterMode =
    "interpreter_mode"


slowMotionVideo: String
slowMotionVideo =
    "slow_motion_video"


framePerson: String
framePerson =
    "frame_person"


playlistAddCheckCircle: String
playlistAddCheckCircle =
    "playlist_add_check_circle"


settingsVoice: String
settingsVoice =
    "settings_voice"


videoSettings: String
videoSettings =
    "video_settings"


featuredPlayList: String
featuredPlayList =
    "featured_play_list"


audioFile: String
audioFile =
    "audio_file"


soundDetectionLoudSound: String
soundDetectionLoudSound =
    "sound_detection_loud_sound"


lyrics: String
lyrics =
    "lyrics"


playLesson: String
playLesson =
    "play_lesson"


hd: String
hd =
    "hd"


repeatOne: String
repeatOne =
    "repeat_one"


callToAction: String
callToAction =
    "call_to_action"


addToQueue: String
addToQueue =
    "add_to_queue"


highQuality: String
highQuality =
    "high_quality"


musicOff: String
musicOff =
    "music_off"


videoCameraBack: String
videoCameraBack =
    "video_camera_back"


spatialAudioOff: String
spatialAudioOff =
    "spatial_audio_off"


shuffleOn: String
shuffleOn =
    "shuffle_on"


playlistAddCircle: String
playlistAddCircle =
    "playlist_add_circle"


volumeDownAlt: String
volumeDownAlt =
    "volume_down_alt"


hearingDisabled: String
hearingDisabled =
    "hearing_disabled"


featuredVideo: String
featuredVideo =
    "featured_video"


replay5: String
replay5 =
    "replay_5"


repeatOn: String
repeatOn =
    "repeat_on"


queuePlayNext: String
queuePlayNext =
    "queue_play_next"


spatialAudio: String
spatialAudio =
    "spatial_audio"


artTrack: String
artTrack =
    "art_track"


explicit: String
explicit =
    "explicit"


airplay: String
airplay =
    "airplay"


speechToText: String
speechToText =
    "speech_to_text"


forward30: String
forward30 =
    "forward_30"


forward5: String
forward5 =
    "forward_5"


i4k: String
i4k =
    "4k"


musicVideo: String
musicVideo =
    "music_video"


replay30: String
replay30 =
    "replay_30"


spatialTracking: String
spatialTracking =
    "spatial_tracking"


controlCamera: String
controlCamera =
    "control_camera"


closedCaptionDisabled: String
closedCaptionDisabled =
    "closed_caption_disabled"


digitalOutOfHome: String
digitalOutOfHome =
    "digital_out_of_home"


videoLabel: String
videoLabel =
    "video_label"


fiberSmartRecord: String
fiberSmartRecord =
    "fiber_smart_record"


playDisabled: String
playDisabled =
    "play_disabled"


repeatOneOn: String
repeatOneOn =
    "repeat_one_on"


broadcastOnPersonal: String
broadcastOnPersonal =
    "broadcast_on_personal"


sd: String
sd =
    "sd"


missedVideoCall: String
missedVideoCall =
    "missed_video_call"


surroundSound: String
surroundSound =
    "surround_sound"


i10k: String
i10k =
    "10k"


fiberPin: String
fiberPin =
    "fiber_pin"


i60fps: String
i60fps =
    "60fps"


soundDetectionGlassBreak: String
soundDetectionGlassBreak =
    "sound_detection_glass_break"


removeFromQueue: String
removeFromQueue =
    "remove_from_queue"


broadcastOnHome: String
broadcastOnHome =
    "broadcast_on_home"


fiberDvr: String
fiberDvr =
    "fiber_dvr"


i30fps: String
i30fps =
    "30fps"


i4kPlus: String
i4kPlus =
    "4k_plus"


videoStable: String
videoStable =
    "video_stable"


i8k: String
i8k =
    "8k"


i1k: String
i1k =
    "1k"


privacy: String
privacy =
    "privacy"


i8kPlus: String
i8kPlus =
    "8k_plus"


i2k: String
i2k =
    "2k"


i7k: String
i7k =
    "7k"


i1kPlus: String
i1kPlus =
    "1k_plus"


i9k: String
i9k =
    "9k"


i9kPlus: String
i9kPlus =
    "9k_plus"


i5k: String
i5k =
    "5k"


i2kPlus: String
i2kPlus =
    "2k_plus"


i5kPlus: String
i5kPlus =
    "5k_plus"


i6k: String
i6k =
    "6k"


i6kPlus: String
i6kPlus =
    "6k_plus"


i3k: String
i3k =
    "3k"


i7kPlus: String
i7kPlus =
    "7k_plus"


i3kPlus: String
i3kPlus =
    "3k_plus"


autoDetectVoice: String
autoDetectVoice =
    "auto_detect_voice"


cinematicBlur: String
cinematicBlur =
    "cinematic_blur"


mediaLink: String
mediaLink =
    "media_link"


videoCameraFrontOff: String
videoCameraFrontOff =
    "video_camera_front_off"


autoplay: String
autoplay =
    "autoplay"


forwardMedia: String
forwardMedia =
    "forward_media"


movieEdit: String
movieEdit =
    "movie_edit"


autoVideocam: String
autoVideocam =
    "auto_videocam"


resume: String
resume =
    "resume"


selectToSpeak: String
selectToSpeak =
    "select_to_speak"


autopause: String
autopause =
    "autopause"


forwardCircle: String
forwardCircle =
    "forward_circle"


autostop: String
autostop =
    "autostop"


soundSampler: String
soundSampler =
    "sound_sampler"


framePersonOff: String
framePersonOff =
    "frame_person_off"


viewInArOff: String
viewInArOff =
    "view_in_ar_off"


localShipping: String
localShipping =
    "local_shipping"


directionsCar: String
directionsCar =
    "directions_car"


flight: String
flight =
    "flight"


directionsRun: String
directionsRun =
    "directions_run"


directionsWalk: String
directionsWalk =
    "directions_walk"


flightTakeoff: String
flightTakeoff =
    "flight_takeoff"


directionsBus: String
directionsBus =
    "directions_bus"


directionsBike: String
directionsBike =
    "directions_bike"


train: String
train =
    "train"


airportShuttle: String
airportShuttle =
    "airport_shuttle"


pedalBike: String
pedalBike =
    "pedal_bike"


directionsBoat: String
directionsBoat =
    "directions_boat"


twoWheeler: String
twoWheeler =
    "two_wheeler"


agriculture: String
agriculture =
    "agriculture"


localTaxi: String
localTaxi =
    "local_taxi"


sailing: String
sailing =
    "sailing"


electricCar: String
electricCar =
    "electric_car"


flightLand: String
flightLand =
    "flight_land"


hail: String
hail =
    "hail"


noCrash: String
noCrash =
    "no_crash"


commute: String
commute =
    "commute"


motorcycle: String
motorcycle =
    "motorcycle"


carCrash: String
carCrash =
    "car_crash"


tram: String
tram =
    "tram"


departureBoard: String
departureBoard =
    "departure_board"


subway: String
subway =
    "subway"


electricMoped: String
electricMoped =
    "electric_moped"


turnRight: String
turnRight =
    "turn_right"


electricScooter: String
electricScooter =
    "electric_scooter"


forkRight: String
forkRight =
    "fork_right"


directionsSubway: String
directionsSubway =
    "directions_subway"


tireRepair: String
tireRepair =
    "tire_repair"


electricBike: String
electricBike =
    "electric_bike"


rvHookup: String
rvHookup =
    "rv_hookup"


busAlert: String
busAlert =
    "bus_alert"


turnLeft: String
turnLeft =
    "turn_left"


transportation: String
transportation =
    "transportation"


airlines: String
airlines =
    "airlines"


taxiAlert: String
taxiAlert =
    "taxi_alert"


uTurnLeft: String
uTurnLeft =
    "u_turn_left"


directionsRailway: String
directionsRailway =
    "directions_railway"


electricRickshaw: String
electricRickshaw =
    "electric_rickshaw"


turnSlightRight: String
turnSlightRight =
    "turn_slight_right"


uTurnRight: String
uTurnRight =
    "u_turn_right"


forkLeft: String
forkLeft =
    "fork_left"


railwayAlert: String
railwayAlert =
    "railway_alert"


bikeScooter: String
bikeScooter =
    "bike_scooter"


turnSharpRight: String
turnSharpRight =
    "turn_sharp_right"


turnSlightLeft: String
turnSlightLeft =
    "turn_slight_left"


noTransfer: String
noTransfer =
    "no_transfer"


snowmobile: String
snowmobile =
    "snowmobile"


turnSharpLeft: String
turnSharpLeft =
    "turn_sharp_left"


ambulance: String
ambulance =
    "ambulance"


school: String
school =
    "school"


campaign: String
campaign =
    "campaign"


construction: String
construction =
    "construction"


engineering: String
engineering =
    "engineering"


volunteerActivism: String
volunteerActivism =
    "volunteer_activism"


science: String
science =
    "science"


sportsEsports: String
sportsEsports =
    "sports_esports"


confirmationNumber: String
confirmationNumber =
    "confirmation_number"


realEstateAgent: String
realEstateAgent =
    "real_estate_agent"


cake: String
cake =
    "cake"


selfImprovement: String
selfImprovement =
    "self_improvement"


sportsSoccer: String
sportsSoccer =
    "sports_soccer"


air: String
air =
    "air"


biotech: String
biotech =
    "biotech"


water: String
water =
    "water"


hiking: String
hiking =
    "hiking"


architecture: String
architecture =
    "architecture"


sportsScore: String
sportsScore =
    "sports_score"


personalInjury: String
personalInjury =
    "personal_injury"


sportsBasketball: String
sportsBasketball =
    "sports_basketball"


waves: String
waves =
    "waves"


theaters: String
theaters =
    "theaters"


sportsTennis: String
sportsTennis =
    "sports_tennis"


switchAccount: String
switchAccount =
    "switch_account"


nightsStay: String
nightsStay =
    "nights_stay"


sportsGymnastics: String
sportsGymnastics =
    "sports_gymnastics"


backpack: String
backpack =
    "backpack"


sportsMotorsports: String
sportsMotorsports =
    "sports_motorsports"


howToVote: String
howToVote =
    "how_to_vote"


sportsKabaddi: String
sportsKabaddi =
    "sports_kabaddi"


surfing: String
surfing =
    "surfing"


piano: String
piano =
    "piano"


sports: String
sports =
    "sports"


toys: String
toys =
    "toys"


sportsVolleyball: String
sportsVolleyball =
    "sports_volleyball"


sportsMartialArts: String
sportsMartialArts =
    "sports_martial_arts"


sportsBaseball: String
sportsBaseball =
    "sports_baseball"


camping: String
camping =
    "camping"


downhillSkiing: String
downhillSkiing =
    "downhill_skiing"


swords: String
swords =
    "swords"


scoreboard: String
scoreboard =
    "scoreboard"


kayaking: String
kayaking =
    "kayaking"


phishing: String
phishing =
    "phishing"


sportsHandball: String
sportsHandball =
    "sports_handball"


sportsFootball: String
sportsFootball =
    "sports_football"


skateboarding: String
skateboarding =
    "skateboarding"


sportsGolf: String
sportsGolf =
    "sports_golf"


sportsCricket: String
sportsCricket =
    "sports_cricket"


toysFan: String
toysFan =
    "toys_fan"


nordicWalking: String
nordicWalking =
    "nordic_walking"


rollerSkating: String
rollerSkating =
    "roller_skating"


kitesurfing: String
kitesurfing =
    "kitesurfing"


rowing: String
rowing =
    "rowing"


scubaDiving: String
scubaDiving =
    "scuba_diving"


storm: String
storm =
    "storm"


sportsMma: String
sportsMma =
    "sports_mma"


paragliding: String
paragliding =
    "paragliding"


snowboarding: String
snowboarding =
    "snowboarding"


sportsHockey: String
sportsHockey =
    "sports_hockey"


iceSkating: String
iceSkating =
    "ice_skating"


snowshoeing: String
snowshoeing =
    "snowshoeing"


sportsRugby: String
sportsRugby =
    "sports_rugby"


sledding: String
sledding =
    "sledding"


pianoOff: String
pianoOff =
    "piano_off"


noBackpack: String
noBackpack =
    "no_backpack"


cakeAdd: String
cakeAdd =
    "cake_add"


sprint: String
sprint =
    "sprint"


healthMetrics: String
healthMetrics =
    "health_metrics"


sleep: String
sleep =
    "sleep"


stressManagement: String
stressManagement =
    "stress_management"


mindfulness: String
mindfulness =
    "mindfulness"


steps: String
steps =
    "steps"


exercise: String
exercise =
    "exercise"


readinessScore: String
readinessScore =
    "readiness_score"


relax: String
relax =
    "relax"


avgTime: String
avgTime =
    "avg_time"


distance: String
distance =
    "distance"


menstrualHealth: String
menstrualHealth =
    "menstrual_health"


laps: String
laps =
    "laps"


ecgHeart: String
ecgHeart =
    "ecg_heart"


onsen: String
onsen =
    "onsen"


podiatry: String
podiatry =
    "podiatry"


floor: String
floor =
    "floor"


bathOutdoor: String
bathOutdoor =
    "bath_outdoor"


bia: String
bia =
    "bia"


azm: String
azm =
    "azm"


fertile: String
fertile =
    "fertile"


avgPace: String
avgPace =
    "avg_pace"


eda: String
eda =
    "eda"


pace: String
pace =
    "pace"


waterMedium: String
waterMedium =
    "water_medium"


interactiveSpace: String
interactiveSpace =
    "interactive_space"


personCelebrate: String
personCelebrate =
    "person_celebrate"


waterFull: String
waterFull =
    "water_full"


elevation: String
elevation =
    "elevation"


personPlay: String
personPlay =
    "person_play"


sauna: String
sauna =
    "sauna"


spo2: String
spo2 =
    "spo2"


bathPrivate: String
bathPrivate =
    "bath_private"


glassCup: String
glassCup =
    "glass_cup"


monitorWeightGain: String
monitorWeightGain =
    "monitor_weight_gain"


sleepScore: String
sleepScore =
    "sleep_score"


waterLoss: String
waterLoss =
    "water_loss"


bathPublicLarge: String
bathPublicLarge =
    "bath_public_large"


checkInOut: String
checkInOut =
    "check_in_out"


hrResting: String
hrResting =
    "hr_resting"


thermometerLoss: String
thermometerLoss =
    "thermometer_loss"


monitorWeightLoss: String
monitorWeightLoss =
    "monitor_weight_loss"


physicalTherapy: String
physicalTherapy =
    "physical_therapy"


playShapes: String
playShapes =
    "play_shapes"


thermometerGain: String
thermometerGain =
    "thermometer_gain"


phoneIphone: String
phoneIphone =
    "phone_iphone"


save: String
save =
    "save"


smartphone: String
smartphone =
    "smartphone"


print: String
print =
    "print"


keyboardArrowDown: String
keyboardArrowDown =
    "keyboard_arrow_down"


computer: String
computer =
    "computer"


devices: String
devices =
    "devices"


desktopWindows: String
desktopWindows =
    "desktop_windows"


smartDisplay: String
smartDisplay =
    "smart_display"


dns: String
dns =
    "dns"


keyboardBackspace: String
keyboardBackspace =
    "keyboard_backspace"


headphones: String
headphones =
    "headphones"


smartToy: String
smartToy =
    "smart_toy"


phoneAndroid: String
phoneAndroid =
    "phone_android"


keyboardArrowRight: String
keyboardArrowRight =
    "keyboard_arrow_right"


memory: String
memory =
    "memory"


liveTv: String
liveTv =
    "live_tv"


keyboard: String
keyboard =
    "keyboard"


laptopMac: String
laptopMac =
    "laptop_mac"


headsetMic: String
headsetMic =
    "headset_mic"


keyboardArrowUp: String
keyboardArrowUp =
    "keyboard_arrow_up"


tv: String
tv =
    "tv"


deviceThermostat: String
deviceThermostat =
    "device_thermostat"


mouse: String
mouse =
    "mouse"


balance: String
balance =
    "balance"


route: String
route =
    "route"


pointOfSale: String
pointOfSale =
    "point_of_sale"


keyboardArrowLeft: String
keyboardArrowLeft =
    "keyboard_arrow_left"


keyboardReturn: String
keyboardReturn =
    "keyboard_return"


laptopChromebook: String
laptopChromebook =
    "laptop_chromebook"


power: String
power =
    "power"


watch: String
watch =
    "watch"


laptopWindows: String
laptopWindows =
    "laptop_windows"


router: String
router =
    "router"


developerBoard: String
developerBoard =
    "developer_board"


displaySettings: String
displaySettings =
    "display_settings"


scale: String
scale =
    "scale"


bookOnline: String
bookOnline =
    "book_online"


fax: String
fax =
    "fax"


developerMode: String
developerMode =
    "developer_mode"


cast: String
cast =
    "cast"


castForEducation: String
castForEducation =
    "cast_for_education"


videogameAsset: String
videogameAsset =
    "videogame_asset"


deviceHub: String
deviceHub =
    "device_hub"


straight: String
straight =
    "straight"


screenSearchDesktop: String
screenSearchDesktop =
    "screen_search_desktop"


desktopMac: String
desktopMac =
    "desktop_mac"


settingsEthernet: String
settingsEthernet =
    "settings_ethernet"


settingsInputAntenna: String
settingsInputAntenna =
    "settings_input_antenna"


mobileFriendly: String
mobileFriendly =
    "mobile_friendly"


monitor: String
monitor =
    "monitor"


importantDevices: String
importantDevices =
    "important_devices"


tabletMac: String
tabletMac =
    "tablet_mac"


sendToMobile: String
sendToMobile =
    "send_to_mobile"


devicesOther: String
devicesOther =
    "devices_other"


systemUpdate: String
systemUpdate =
    "system_update"


settingsRemote: String
settingsRemote =
    "settings_remote"


monitorWeight: String
monitorWeight =
    "monitor_weight"


screenRotation: String
screenRotation =
    "screen_rotation"


screenShare: String
screenShare =
    "screen_share"


keyboardAlt: String
keyboardAlt =
    "keyboard_alt"


settingsInputComponent: String
settingsInputComponent =
    "settings_input_component"


speaker: String
speaker =
    "speaker"


simCard: String
simCard =
    "sim_card"


merge: String
merge =
    "merge"


keyboardTab: String
keyboardTab =
    "keyboard_tab"


vibration: String
vibration =
    "vibration"


powerOff: String
powerOff =
    "power_off"


screenshotMonitor: String
screenshotMonitor =
    "screenshot_monitor"


connectedTv: String
connectedTv =
    "connected_tv"


rememberMe: String
rememberMe =
    "remember_me"


tablet: String
tablet =
    "tablet"


browserUpdated: String
browserUpdated =
    "browser_updated"


securityUpdateGood: String
securityUpdateGood =
    "security_update_good"


sdCard: String
sdCard =
    "sd_card"


castConnected: String
castConnected =
    "cast_connected"


deviceUnknown: String
deviceUnknown =
    "device_unknown"


tabletAndroid: String
tabletAndroid =
    "tablet_android"


chargingStation: String
chargingStation =
    "charging_station"


phonelinkSetup: String
phonelinkSetup =
    "phonelink_setup"


punchClock: String
punchClock =
    "punch_clock"


scanner: String
scanner =
    "scanner"


screenshot: String
screenshot =
    "screenshot"


settingsInputHdmi: String
settingsInputHdmi =
    "settings_input_hdmi"


stayCurrentPortrait: String
stayCurrentPortrait =
    "stay_current_portrait"


tapAndPlay: String
tapAndPlay =
    "tap_and_play"


keyboardHide: String
keyboardHide =
    "keyboard_hide"


printDisabled: String
printDisabled =
    "print_disabled"


securityUpdateWarning: String
securityUpdateWarning =
    "security_update_warning"


discFull: String
discFull =
    "disc_full"


keyboardCapslock: String
keyboardCapslock =
    "keyboard_capslock"


appBlocking: String
appBlocking =
    "app_blocking"


speakerGroup: String
speakerGroup =
    "speaker_group"


mobileScreenShare: String
mobileScreenShare =
    "mobile_screen_share"


aod: String
aod =
    "aod"


sdCardAlert: String
sdCardAlert =
    "sd_card_alert"


tty: String
tty =
    "tty"


liftToTalk: String
liftToTalk =
    "lift_to_talk"


addToHomeScreen: String
addToHomeScreen =
    "add_to_home_screen"


earbuds: String
earbuds =
    "earbuds"


permDeviceInformation: String
permDeviceInformation =
    "perm_device_information"


stopScreenShare: String
stopScreenShare =
    "stop_screen_share"


mobileOff: String
mobileOff =
    "mobile_off"


headsetOff: String
headsetOff =
    "headset_off"


desktopAccessDisabled: String
desktopAccessDisabled =
    "desktop_access_disabled"


resetTv: String
resetTv =
    "reset_tv"


offlineShare: String
offlineShare =
    "offline_share"


adfScanner: String
adfScanner =
    "adf_scanner"


headphonesBattery: String
headphonesBattery =
    "headphones_battery"


screenLockPortrait: String
screenLockPortrait =
    "screen_lock_portrait"


roundaboutRight: String
roundaboutRight =
    "roundabout_right"


settopComponent: String
settopComponent =
    "settop_component"


dock: String
dock =
    "dock"


settingsInputSvideo: String
settingsInputSvideo =
    "settings_input_svideo"


watchOff: String
watchOff =
    "watch_off"


smartScreen: String
smartScreen =
    "smart_screen"


stayCurrentLandscape: String
stayCurrentLandscape =
    "stay_current_landscape"


chromecastDevice: String
chromecastDevice =
    "chromecast_device"


settingsCell: String
settingsCell =
    "settings_cell"


earbudsBattery: String
earbudsBattery =
    "earbuds_battery"


homeMax: String
homeMax =
    "home_max"


powerInput: String
powerInput =
    "power_input"


noSim: String
noSim =
    "no_sim"


screenLockLandscape: String
screenLockLandscape =
    "screen_lock_landscape"


rampRight: String
rampRight =
    "ramp_right"


developerBoardOff: String
developerBoardOff =
    "developer_board_off"


roundaboutLeft: String
roundaboutLeft =
    "roundabout_left"


stayPrimaryPortrait: String
stayPrimaryPortrait =
    "stay_primary_portrait"


stayPrimaryLandscape: String
stayPrimaryLandscape =
    "stay_primary_landscape"


tvOff: String
tvOff =
    "tv_off"


homeMini: String
homeMini =
    "home_mini"


phonelinkOff: String
phonelinkOff =
    "phonelink_off"


rampLeft: String
rampLeft =
    "ramp_left"


screenLockRotation: String
screenLockRotation =
    "screen_lock_rotation"


videogameAssetOff: String
videogameAssetOff =
    "videogame_asset_off"


aodTablet: String
aodTablet =
    "aod_tablet"


gamepad: String
gamepad =
    "gamepad"


robot: String
robot =
    "robot"


ambientScreen: String
ambientScreen =
    "ambient_screen"


devicesWearables: String
devicesWearables =
    "devices_wearables"


aodWatch: String
aodWatch =
    "aod_watch"


rearCamera: String
rearCamera =
    "rear_camera"


ecg: String
ecg =
    "ecg"


hardDrive: String
hardDrive =
    "hard_drive"


nightSightMax: String
nightSightMax =
    "night_sight_max"


pacemaker: String
pacemaker =
    "pacemaker"


screenshotTablet: String
screenshotTablet =
    "screenshot_tablet"


devicesOff: String
devicesOff =
    "devices_off"


touchpadMouse: String
touchpadMouse =
    "touchpad_mouse"


memoryAlt: String
memoryAlt =
    "memory_alt"


streamApps: String
streamApps =
    "stream_apps"


cameraVideo: String
cameraVideo =
    "camera_video"


deskphone: String
deskphone =
    "deskphone"


hardDrive2: String
hardDrive2 =
    "hard_drive_2"


watchWake: String
watchWake =
    "watch_wake"


lda: String
lda =
    "lda"


printAdd: String
printAdd =
    "print_add"


printConnect: String
printConnect =
    "print_connect"


printError: String
printError =
    "print_error"


printLock: String
printLock =
    "print_lock"


ventilator: String
ventilator =
    "ventilator"


watchButtonPress: String
watchButtonPress =
    "watch_button_press"


darkMode: String
darkMode =
    "dark_mode"


lightMode: String
lightMode =
    "light_mode"


wifi: String
wifi =
    "wifi"


signalCellularAlt: String
signalCellularAlt =
    "signal_cellular_alt"


password: String
password =
    "password"


widgets: String
widgets =
    "widgets"


pin: String
pin =
    "pin"


storage: String
storage =
    "storage"


rssFeed: String
rssFeed =
    "rss_feed"


batteryFull: String
batteryFull =
    "battery_full"


android: String
android =
    "android"


wifiOff: String
wifiOff =
    "wifi_off"


bluetooth: String
bluetooth =
    "bluetooth"


batteryChargingFull: String
batteryChargingFull =
    "battery_charging_full"


dvr: String
dvr =
    "dvr"


thermostat: String
thermostat =
    "thermostat"


graphicEq: String
graphicEq =
    "graphic_eq"


nightlight: String
nightlight =
    "nightlight"


battery5Bar: String
battery5Bar =
    "battery_5_bar"


signalWifi4Bar: String
signalWifi4Bar =
    "signal_wifi_4_bar"


gppMaybe: String
gppMaybe =
    "gpp_maybe"


cable: String
cable =
    "cable"


gppBad: String
gppBad =
    "gpp_bad"


dataUsage: String
dataUsage =
    "data_usage"


battery4Bar: String
battery4Bar =
    "battery_4_bar"


batteryFullAlt: String
batteryFullAlt =
    "battery_full_alt"


signalCellular4Bar: String
signalCellular4Bar =
    "signal_cellular_4_bar"


airplanemodeActive: String
airplanemodeActive =
    "airplanemode_active"


radar: String
radar =
    "radar"


battery0Bar: String
battery0Bar =
    "battery_0_bar"


cameraswitch: String
cameraswitch =
    "cameraswitch"


wallpaper: String
wallpaper =
    "wallpaper"


signalDisconnected: String
signalDisconnected =
    "signal_disconnected"


flashlightOn: String
flashlightOn =
    "flashlight_on"


networkCheck: String
networkCheck =
    "network_check"


battery6Bar: String
battery6Bar =
    "battery_6_bar"


charger: String
charger =
    "charger"


wifiTethering: String
wifiTethering =
    "wifi_tethering"


simCardDownload: String
simCardDownload =
    "sim_card_download"


usb: String
usb =
    "usb"


quickPhrases: String
quickPhrases =
    "quick_phrases"


splitscreen: String
splitscreen =
    "splitscreen"


battery3Bar: String
battery3Bar =
    "battery_3_bar"


battery1Bar: String
battery1Bar =
    "battery_1_bar"


adb: String
adb =
    "adb"


networkWifi3Bar: String
networkWifi3Bar =
    "network_wifi_3_bar"


batteryLow: String
batteryLow =
    "battery_low"


batteryAlert: String
batteryAlert =
    "battery_alert"


bluetoothSearching: String
bluetoothSearching =
    "bluetooth_searching"


networkWifi: String
networkWifi =
    "network_wifi"


bluetoothConnected: String
bluetoothConnected =
    "bluetooth_connected"


wifiFind: String
wifiFind =
    "wifi_find"


i5g: String
i5g =
    "5g"


battery2Bar: String
battery2Bar =
    "battery_2_bar"


brightnessHigh: String
brightnessHigh =
    "brightness_high"


networkCell: String
networkCell =
    "network_cell"


nfc: String
nfc =
    "nfc"


pattern: String
pattern =
    "pattern"


dataSaverOn: String
dataSaverOn =
    "data_saver_on"


bluetoothDisabled: String
bluetoothDisabled =
    "bluetooth_disabled"


signalWifiStatusbarNotConnected: String
signalWifiStatusbarNotConnected =
    "signal_wifi_statusbar_not_connected"


signalWifiBad: String
signalWifiBad =
    "signal_wifi_bad"


signalCellular3Bar: String
signalCellular3Bar =
    "signal_cellular_3_bar"


noiseControlOff: String
noiseControlOff =
    "noise_control_off"


networkWifi2Bar: String
networkWifi2Bar =
    "network_wifi_2_bar"


networkWifi1Bar: String
networkWifi1Bar =
    "network_wifi_1_bar"


signalWifiOff: String
signalWifiOff =
    "signal_wifi_off"


brightnessMedium: String
brightnessMedium =
    "brightness_medium"


modeStandby: String
modeStandby =
    "mode_standby"


brightnessLow: String
brightnessLow =
    "brightness_low"


batteryVeryLow: String
batteryVeryLow =
    "battery_very_low"


mobiledataOff: String
mobiledataOff =
    "mobiledata_off"


signalWifi0Bar: String
signalWifi0Bar =
    "signal_wifi_0_bar"


grid4x4: String
grid4x4 =
    "grid_4x4"


batteryCharging20: String
batteryCharging20 =
    "battery_charging_20"


batteryCharging80: String
batteryCharging80 =
    "battery_charging_80"


batterySaver: String
batterySaver =
    "battery_saver"


batteryCharging90: String
batteryCharging90 =
    "battery_charging_90"


flashlightOff: String
flashlightOff =
    "flashlight_off"


signalWifiStatusbarNull: String
signalWifiStatusbarNull =
    "signal_wifi_statusbar_null"


settingsSystemDaydream: String
settingsSystemDaydream =
    "settings_system_daydream"


batteryCharging50: String
batteryCharging50 =
    "battery_charging_50"


batteryUnknown: String
batteryUnknown =
    "battery_unknown"


signalCellular2Bar: String
signalCellular2Bar =
    "signal_cellular_2_bar"


screenRotationAlt: String
screenRotationAlt =
    "screen_rotation_alt"


wifiCalling3: String
wifiCalling3 =
    "wifi_calling_3"


badgeCriticalBattery: String
badgeCriticalBattery =
    "badge_critical_battery"


i4gMobiledata: String
i4gMobiledata =
    "4g_mobiledata"


signalCellular1Bar: String
signalCellular1Bar =
    "signal_cellular_1_bar"


noiseAware: String
noiseAware =
    "noise_aware"


batteryCharging60: String
batteryCharging60 =
    "battery_charging_60"


nearbyError: String
nearbyError =
    "nearby_error"


wifiLock: String
wifiLock =
    "wifi_lock"


doNotDisturbOnTotalSilence: String
doNotDisturbOnTotalSilence =
    "do_not_disturb_on_total_silence"


signalCellularConnectedNoInternet0Bar: String
signalCellularConnectedNoInternet0Bar =
    "signal_cellular_connected_no_internet_0_bar"


battery20: String
battery20 =
    "battery_20"


signalCellular0Bar: String
signalCellular0Bar =
    "signal_cellular_0_bar"


batteryCharging30: String
batteryCharging30 =
    "battery_charging_30"


networkPing: String
networkPing =
    "network_ping"


brightnessAuto: String
brightnessAuto =
    "brightness_auto"


wifiTetheringError: String
wifiTetheringError =
    "wifi_tethering_error"


edgesensorHigh: String
edgesensorHigh =
    "edgesensor_high"


wifiCalling1: String
wifiCalling1 =
    "wifi_calling_1"


signalCellularConnectedNoInternet4Bar: String
signalCellularConnectedNoInternet4Bar =
    "signal_cellular_connected_no_internet_4_bar"


wifi2Bar: String
wifi2Bar =
    "wifi_2_bar"


battery30: String
battery30 =
    "battery_30"


battery50: String
battery50 =
    "battery_50"


airplanemodeInactive: String
airplanemodeInactive =
    "airplanemode_inactive"


grid3x3: String
grid3x3 =
    "grid_3x3"


lteMobiledata: String
lteMobiledata =
    "lte_mobiledata"


permDataSetting: String
permDataSetting =
    "perm_data_setting"


i1xMobiledata: String
i1xMobiledata =
    "1x_mobiledata"


signalCellularAlt2Bar: String
signalCellularAlt2Bar =
    "signal_cellular_alt_2_bar"


battery60: String
battery60 =
    "battery_60"


bluetoothDrive: String
bluetoothDrive =
    "bluetooth_drive"


signalCellularNodata: String
signalCellularNodata =
    "signal_cellular_nodata"


permScanWifi: String
permScanWifi =
    "perm_scan_wifi"


devicesFold: String
devicesFold =
    "devices_fold"


battery90: String
battery90 =
    "battery_90"


wifiCalling2: String
wifiCalling2 =
    "wifi_calling_2"


i4gPlusMobiledata: String
i4gPlusMobiledata =
    "4g_plus_mobiledata"


mediaBluetoothOn: String
mediaBluetoothOn =
    "media_bluetooth_on"


networkLocked: String
networkLocked =
    "network_locked"


signalCellularOff: String
signalCellularOff =
    "signal_cellular_off"


battery80: String
battery80 =
    "battery_80"


timer10Select: String
timer10Select =
    "timer_10_select"


signalCellularAlt1Bar: String
signalCellularAlt1Bar =
    "signal_cellular_alt_1_bar"


wifiTetheringOff: String
wifiTetheringOff =
    "wifi_tethering_off"


edgesensorLow: String
edgesensorLow =
    "edgesensor_low"


usbOff: String
usbOff =
    "usb_off"


wifi1Bar: String
wifi1Bar =
    "wifi_1_bar"


i3gMobiledata: String
i3gMobiledata =
    "3g_mobiledata"


apkInstall: String
apkInstall =
    "apk_install"


signalCellularNull: String
signalCellularNull =
    "signal_cellular_null"


ltePlusMobiledata: String
ltePlusMobiledata =
    "lte_plus_mobiledata"


gridGoldenratio: String
gridGoldenratio =
    "grid_goldenratio"


gMobiledata: String
gMobiledata =
    "g_mobiledata"


portableWifiOff: String
portableWifiOff =
    "portable_wifi_off"


noiseControlOn: String
noiseControlOn =
    "noise_control_on"


mediaBluetoothOff: String
mediaBluetoothOff =
    "media_bluetooth_off"


timer3Select: String
timer3Select =
    "timer_3_select"


eMobiledata: String
eMobiledata =
    "e_mobiledata"


apkDocument: String
apkDocument =
    "apk_document"


nearbyOff: String
nearbyOff =
    "nearby_off"


hMobiledata: String
hMobiledata =
    "h_mobiledata"


rMobiledata: String
rMobiledata =
    "r_mobiledata"


hPlusMobiledata: String
hPlusMobiledata =
    "h_plus_mobiledata"


dualScreen: String
dualScreen =
    "dual_screen"


screenshotRegion: String
screenshotRegion =
    "screenshot_region"


overviewKey: String
overviewKey =
    "overview_key"


dockToLeft: String
dockToLeft =
    "dock_to_left"


dockToRight: String
dockToRight =
    "dock_to_right"


magicTether: String
magicTether =
    "magic_tether"


keyboardExternalInput: String
keyboardExternalInput =
    "keyboard_external_input"


keyboardOff: String
keyboardOff =
    "keyboard_off"


magnifyDocked: String
magnifyDocked =
    "magnify_docked"


magnifyFullscreen: String
magnifyFullscreen =
    "magnify_fullscreen"


i1xMobiledataBadge: String
i1xMobiledataBadge =
    "1x_mobiledata_badge"


i5gMobiledataBadge: String
i5gMobiledataBadge =
    "5g_mobiledata_badge"


batteryPlus: String
batteryPlus =
    "battery_plus"


brightnessEmpty: String
brightnessEmpty =
    "brightness_empty"


displayExternalInput: String
displayExternalInput =
    "display_external_input"


dockToBottom: String
dockToBottom =
    "dock_to_bottom"


keyboardCapslockBadge: String
keyboardCapslockBadge =
    "keyboard_capslock_badge"


keyboardKeys: String
keyboardKeys =
    "keyboard_keys"


lteMobiledataBadge: String
lteMobiledataBadge =
    "lte_mobiledata_badge"


screenRecord: String
screenRecord =
    "screen_record"


i3gMobiledataBadge: String
i3gMobiledataBadge =
    "3g_mobiledata_badge"


i4gMobiledataBadge: String
i4gMobiledataBadge =
    "4g_mobiledata_badge"


backlightHigh: String
backlightHigh =
    "backlight_high"


backlightLow: String
backlightLow =
    "backlight_low"


batteryChange: String
batteryChange =
    "battery_change"


batteryError: String
batteryError =
    "battery_error"


batteryShare: String
batteryShare =
    "battery_share"


batteryStatusGood: String
batteryStatusGood =
    "battery_status_good"


eMobiledataBadge: String
eMobiledataBadge =
    "e_mobiledata_badge"


evMobiledataBadge: String
evMobiledataBadge =
    "ev_mobiledata_badge"


gMobiledataBadge: String
gMobiledataBadge =
    "g_mobiledata_badge"


grid3x3Off: String
grid3x3Off =
    "grid_3x3_off"


hMobiledataBadge: String
hMobiledataBadge =
    "h_mobiledata_badge"


hPlusMobiledataBadge: String
hPlusMobiledataBadge =
    "h_plus_mobiledata_badge"


keyboardFull: String
keyboardFull =
    "keyboard_full"


keyboardOnscreen: String
keyboardOnscreen =
    "keyboard_onscreen"


keyboardPreviousLanguage: String
keyboardPreviousLanguage =
    "keyboard_previous_language"


ltePlusMobiledataBadge: String
ltePlusMobiledataBadge =
    "lte_plus_mobiledata_badge"


screenRotationUp: String
screenRotationUp =
    "screen_rotation_up"


screenshotFrame: String
screenshotFrame =
    "screenshot_frame"


screenshotKeyboard: String
screenshotKeyboard =
    "screenshot_keyboard"


splitscreenBottom: String
splitscreenBottom =
    "splitscreen_bottom"


splitscreenLeft: String
splitscreenLeft =
    "splitscreen_left"


splitscreenRight: String
splitscreenRight =
    "splitscreen_right"


splitscreenTop: String
splitscreenTop =
    "splitscreen_top"


wallpaperSlideshow: String
wallpaperSlideshow =
    "wallpaper_slideshow"


wifiHome: String
wifiHome =
    "wifi_home"


wifiNotification: String
wifiNotification =
    "wifi_notification"


badge: String
badge =
    "badge"


verifiedUser: String
verifiedUser =
    "verified_user"


adminPanelSettings: String
adminPanelSettings =
    "admin_panel_settings"


report: String
report =
    "report"


security: String
security =
    "security"


vpnKey: String
vpnKey =
    "vpn_key"


shield: String
shield =
    "shield"


policy: String
policy =
    "policy"


exclamation: String
exclamation =
    "exclamation"


privacyTip: String
privacyTip =
    "privacy_tip"


assuredWorkload: String
assuredWorkload =
    "assured_workload"


vpnLock: String
vpnLock =
    "vpn_lock"


disabledVisible: String
disabledVisible =
    "disabled_visible"


e911Emergency: String
e911Emergency =
    "e911_emergency"


enhancedEncryption: String
enhancedEncryption =
    "enhanced_encryption"


privateConnectivity: String
privateConnectivity =
    "private_connectivity"


vpnKeyOff: String
vpnKeyOff =
    "vpn_key_off"


addModerator: String
addModerator =
    "add_moderator"


noEncryption: String
noEncryption =
    "no_encryption"


syncLock: String
syncLock =
    "sync_lock"


wifiPassword: String
wifiPassword =
    "wifi_password"


keyVisualizer: String
keyVisualizer =
    "key_visualizer"


removeModerator: String
removeModerator =
    "remove_moderator"


reportOff: String
reportOff =
    "report_off"


shieldLock: String
shieldLock =
    "shield_lock"


shieldPerson: String
shieldPerson =
    "shield_person"


vpnKeyAlert: String
vpnKeyAlert =
    "vpn_key_alert"


apartment: String
apartment =
    "apartment"


locationCity: String
locationCity =
    "location_city"


fitnessCenter: String
fitnessCenter =
    "fitness_center"


lunchDining: String
lunchDining =
    "lunch_dining"


spa: String
spa =
    "spa"


cottage: String
cottage =
    "cottage"


localCafe: String
localCafe =
    "local_cafe"


hotel: String
hotel =
    "hotel"


familyRestroom: String
familyRestroom =
    "family_restroom"


beachAccess: String
beachAccess =
    "beach_access"


localBar: String
localBar =
    "local_bar"


pool: String
pool =
    "pool"


otherHouses: String
otherHouses =
    "other_houses"


luggage: String
luggage =
    "luggage"


liquor: String
liquor =
    "liquor"


airplaneTicket: String
airplaneTicket =
    "airplane_ticket"


casino: String
casino =
    "casino"


sportsBar: String
sportsBar =
    "sports_bar"


bakeryDining: String
bakeryDining =
    "bakery_dining"


ramenDining: String
ramenDining =
    "ramen_dining"


nightlife: String
nightlife =
    "nightlife"


localDining: String
localDining =
    "local_dining"


holidayVillage: String
holidayVillage =
    "holiday_village"


icecream: String
icecream =
    "icecream"


escalatorWarning: String
escalatorWarning =
    "escalator_warning"


dinnerDining: String
dinnerDining =
    "dinner_dining"


museum: String
museum =
    "museum"


foodBank: String
foodBank =
    "food_bank"


nightShelter: String
nightShelter =
    "night_shelter"


festival: String
festival =
    "festival"


attractions: String
attractions =
    "attractions"


golfCourse: String
golfCourse =
    "golf_course"


stairs: String
stairs =
    "stairs"


villa: String
villa =
    "villa"


smokeFree: String
smokeFree =
    "smoke_free"


smokingRooms: String
smokingRooms =
    "smoking_rooms"


carRental: String
carRental =
    "car_rental"


airlineSeatReclineNormal: String
airlineSeatReclineNormal =
    "airline_seat_recline_normal"


elevator: String
elevator =
    "elevator"


gite: String
gite =
    "gite"


childFriendly: String
childFriendly =
    "child_friendly"


airlineSeatReclineExtra: String
airlineSeatReclineExtra =
    "airline_seat_recline_extra"


breakfastDining: String
breakfastDining =
    "breakfast_dining"


carpenter: String
carpenter =
    "carpenter"


carRepair: String
carRepair =
    "car_repair"


cabin: String
cabin =
    "cabin"


brunchDining: String
brunchDining =
    "brunch_dining"


noFood: String
noFood =
    "no_food"


houseboat: String
houseboat =
    "houseboat"


doNotTouch: String
doNotTouch =
    "do_not_touch"


riceBowl: String
riceBowl =
    "rice_bowl"


tapas: String
tapas =
    "tapas"


wheelchairPickup: String
wheelchairPickup =
    "wheelchair_pickup"


bento: String
bento =
    "bento"


noDrinks: String
noDrinks =
    "no_drinks"


doNotStep: String
doNotStep =
    "do_not_step"


airlineSeatFlat: String
airlineSeatFlat =
    "airline_seat_flat"


bungalow: String
bungalow =
    "bungalow"


airlineSeatIndividualSuite: String
airlineSeatIndividualSuite =
    "airline_seat_individual_suite"


escalator: String
escalator =
    "escalator"


chalet: String
chalet =
    "chalet"


noLuggage: String
noLuggage =
    "no_luggage"


airlineSeatLegroomExtra: String
airlineSeatLegroomExtra =
    "airline_seat_legroom_extra"


airlineSeatFlatAngled: String
airlineSeatFlatAngled =
    "airline_seat_flat_angled"


airlineSeatLegroomNormal: String
airlineSeatLegroomNormal =
    "airline_seat_legroom_normal"


airlineSeatLegroomReduced: String
airlineSeatLegroomReduced =
    "airline_seat_legroom_reduced"


noStroller: String
noStroller =
    "no_stroller"


house: String
house =
    "house"


bed: String
bed =
    "bed"


acUnit: String
acUnit =
    "ac_unit"


chair: String
chair =
    "chair"


coffee: String
coffee =
    "coffee"


electricBolt: String
electricBolt =
    "electric_bolt"


childCare: String
childCare =
    "child_care"


sensors: String
sensors =
    "sensors"


backHand: String
backHand =
    "back_hand"


checkroom: String
checkroom =
    "checkroom"


grass: String
grass =
    "grass"


emergencyHome: String
emergencyHome =
    "emergency_home"


shower: String
shower =
    "shower"


modeFan: String
modeFan =
    "mode_fan"


mop: String
mop =
    "mop"


kitchen: String
kitchen =
    "kitchen"


roomService: String
roomService =
    "room_service"


thermometer: String
thermometer =
    "thermometer"


styler: String
styler =
    "styler"


yard: String
yard =
    "yard"


bathtub: String
bathtub =
    "bathtub"


kingBed: String
kingBed =
    "king_bed"


roofing: String
roofing =
    "roofing"


energySavingsLeaf: String
energySavingsLeaf =
    "energy_savings_leaf"


window: String
window =
    "window"


cooking: String
cooking =
    "cooking"


valve: String
valve =
    "valve"


garageHome: String
garageHome =
    "garage_home"


doorFront: String
doorFront =
    "door_front"


modeHeat: String
modeHeat =
    "mode_heat"


light: String
light =
    "light"


foundation: String
foundation =
    "foundation"


outdoorGrill: String
outdoorGrill =
    "outdoor_grill"


garage: String
garage =
    "garage"


dining: String
dining =
    "dining"


tableRestaurant: String
tableRestaurant =
    "table_restaurant"


deck: String
deck =
    "deck"


weekend: String
weekend =
    "weekend"


coffeeMaker: String
coffeeMaker =
    "coffee_maker"


sensorOccupied: String
sensorOccupied =
    "sensor_occupied"


flatware: String
flatware =
    "flatware"


humidityHigh: String
humidityHigh =
    "humidity_high"


fireplace: String
fireplace =
    "fireplace"


highlight: String
highlight =
    "highlight"


modeNight: String
modeNight =
    "mode_night"


humidityLow: String
humidityLow =
    "humidity_low"


electricMeter: String
electricMeter =
    "electric_meter"


tvGen: String
tvGen =
    "tv_gen"


humidityMid: String
humidityMid =
    "humidity_mid"


bedroomParent: String
bedroomParent =
    "bedroom_parent"


chairAlt: String
chairAlt =
    "chair_alt"


blender: String
blender =
    "blender"


microwave: String
microwave =
    "microwave"


scene: String
scene =
    "scene"


singleBed: String
singleBed =
    "single_bed"


heatPump: String
heatPump =
    "heat_pump"


ovenGen: String
ovenGen =
    "oven_gen"


bedroomBaby: String
bedroomBaby =
    "bedroom_baby"


bathroom: String
bathroom =
    "bathroom"


inHomeMode: String
inHomeMode =
    "in_home_mode"


hotTub: String
hotTub =
    "hot_tub"


modeOffOn: String
modeOffOn =
    "mode_off_on"


hardware: String
hardware =
    "hardware"


sprinkler: String
sprinkler =
    "sprinkler"


tableBar: String
tableBar =
    "table_bar"


gasMeter: String
gasMeter =
    "gas_meter"


crib: String
crib =
    "crib"


soap: String
soap =
    "soap"


countertops: String
countertops =
    "countertops"


living: String
living =
    "living"


modeCool: String
modeCool =
    "mode_cool"


homeIotDevice: String
homeIotDevice =
    "home_iot_device"


fireExtinguisher: String
fireExtinguisher =
    "fire_extinguisher"


propaneTank: String
propaneTank =
    "propane_tank"


outlet: String
outlet =
    "outlet"


remoteGen: String
remoteGen =
    "remote_gen"


sensorDoor: String
sensorDoor =
    "sensor_door"


gate: String
gate =
    "gate"


airware: String
airware =
    "airware"


eventSeat: String
eventSeat =
    "event_seat"


matter: String
matter =
    "matter"


faucet: String
faucet =
    "faucet"


dishwasherGen: String
dishwasherGen =
    "dishwasher_gen"


balcony: String
balcony =
    "balcony"


energyProgramSaving: String
energyProgramSaving =
    "energy_program_saving"


airFreshener: String
airFreshener =
    "air_freshener"


wash: String
wash =
    "wash"


cameraIndoor: String
cameraIndoor =
    "camera_indoor"


waterDamage: String
waterDamage =
    "water_damage"


bedroomChild: String
bedroomChild =
    "bedroom_child"


houseSiding: String
houseSiding =
    "house_siding"


microwaveGen: String
microwaveGen =
    "microwave_gen"


switch: String
switch =
    "switch"


detectorSmoke: String
detectorSmoke =
    "detector_smoke"


doorSliding: String
doorSliding =
    "door_sliding"


iron: String
iron =
    "iron"


energyProgramTimeUsed: String
energyProgramTimeUsed =
    "energy_program_time_used"


desk: String
desk =
    "desk"


waterHeater: String
waterHeater =
    "water_heater"


umbrella: String
umbrella =
    "umbrella"


dresser: String
dresser =
    "dresser"


doorBack: String
doorBack =
    "door_back"


doorbell: String
doorbell =
    "doorbell"


fence: String
fence =
    "fence"


modeFanOff: String
modeFanOff =
    "mode_fan_off"


hvac: String
hvac =
    "hvac"


cameraOutdoor: String
cameraOutdoor =
    "camera_outdoor"


kettle: String
kettle =
    "kettle"


emergencyHeat: String
emergencyHeat =
    "emergency_heat"


airPurifierGen: String
airPurifierGen =
    "air_purifier_gen"


emergencyShare: String
emergencyShare =
    "emergency_share"


stroller: String
stroller =
    "stroller"


googleWifi: String
googleWifi =
    "google_wifi"


curtains: String
curtains =
    "curtains"


multicooker: String
multicooker =
    "multicooker"


shieldMoon: String
shieldMoon =
    "shield_moon"


sensorsOff: String
sensorsOff =
    "sensors_off"


modeHeatCool: String
modeHeatCool =
    "mode_heat_cool"


thermostatAuto: String
thermostatAuto =
    "thermostat_auto"


emergencyRecording: String
emergencyRecording =
    "emergency_recording"


smartOutlet: String
smartOutlet =
    "smart_outlet"


blinds: String
blinds =
    "blinds"


controllerGen: String
controllerGen =
    "controller_gen"


rollerShades: String
rollerShades =
    "roller_shades"


dry: String
dry =
    "dry"


blindsClosed: String
blindsClosed =
    "blinds_closed"


rollerShadesClosed: String
rollerShadesClosed =
    "roller_shades_closed"


propane: String
propane =
    "propane"


sensorWindow: String
sensorWindow =
    "sensor_window"


thermostatCarbon: String
thermostatCarbon =
    "thermostat_carbon"


rangeHood: String
rangeHood =
    "range_hood"


doorbell3p: String
doorbell3p =
    "doorbell_3p"


blanket: String
blanket =
    "blanket"


tvWithAssistant: String
tvWithAssistant =
    "tv_with_assistant"


verticalShadesClosed: String
verticalShadesClosed =
    "vertical_shades_closed"


verticalShades: String
verticalShades =
    "vertical_shades"


curtainsClosed: String
curtainsClosed =
    "curtains_closed"


modeHeatOff: String
modeHeatOff =
    "mode_heat_off"


modeCoolOff: String
modeCoolOff =
    "mode_cool_off"


tamperDetectionOff: String
tamperDetectionOff =
    "tamper_detection_off"


shelves: String
shelves =
    "shelves"


stadiaController: String
stadiaController =
    "stadia_controller"


tempPreferencesCustom: String
tempPreferencesCustom =
    "temp_preferences_custom"


doorOpen: String
doorOpen =
    "door_open"


powerRounded: String
powerRounded =
    "power_rounded"


nestEcoLeaf: String
nestEcoLeaf =
    "nest_eco_leaf"


deviceReset: String
deviceReset =
    "device_reset"


nestClockFarsightAnalog: String
nestClockFarsightAnalog =
    "nest_clock_farsight_analog"


nestRemoteComfortSensor: String
nestRemoteComfortSensor =
    "nest_remote_comfort_sensor"


laundry: String
laundry =
    "laundry"


batteryHoriz075: String
batteryHoriz075 =
    "battery_horiz_075"


shieldWithHeart: String
shieldWithHeart =
    "shield_with_heart"


tempPreferencesEco: String
tempPreferencesEco =
    "temp_preferences_eco"


familiarFaceAndZone: String
familiarFaceAndZone =
    "familiar_face_and_zone"


toolsPowerDrill: String
toolsPowerDrill =
    "tools_power_drill"


airwave: String
airwave =
    "airwave"


productivity: String
productivity =
    "productivity"


batteryHoriz050: String
batteryHoriz050 =
    "battery_horiz_050"


nestHeatLinkGen3: String
nestHeatLinkGen3 =
    "nest_heat_link_gen_3"


nestDisplay: String
nestDisplay =
    "nest_display"


weatherSnowy: String
weatherSnowy =
    "weather_snowy"


activityZone: String
activityZone =
    "activity_zone"


evCharger: String
evCharger =
    "ev_charger"


nestRemote: String
nestRemote =
    "nest_remote"


cleaningBucket: String
cleaningBucket =
    "cleaning_bucket"


settingsAlert: String
settingsAlert =
    "settings_alert"


nestCamIndoor: String
nestCamIndoor =
    "nest_cam_indoor"


arrowsMoreUp: String
arrowsMoreUp =
    "arrows_more_up"


nestHeatLinkE: String
nestHeatLinkE =
    "nest_heat_link_e"


homeStorage: String
homeStorage =
    "home_storage"


nestMultiRoom: String
nestMultiRoom =
    "nest_multi_room"


nestSecureAlarm: String
nestSecureAlarm =
    "nest_secure_alarm"


batteryHoriz000: String
batteryHoriz000 =
    "battery_horiz_000"


nestCamOutdoor: String
nestCamOutdoor =
    "nest_cam_outdoor"


lightGroup: String
lightGroup =
    "light_group"


detectionAndZone: String
detectionAndZone =
    "detection_and_zone"


nestThermostatGen3: String
nestThermostatGen3 =
    "nest_thermostat_gen_3"


mfgNestYaleLock: String
mfgNestYaleLock =
    "mfg_nest_yale_lock"


toolsPliersWireStripper: String
toolsPliersWireStripper =
    "tools_pliers_wire_stripper"


nestCamIqOutdoor: String
nestCamIqOutdoor =
    "nest_cam_iq_outdoor"


toolsLadder: String
toolsLadder =
    "tools_ladder"


detectorAlarm: String
detectorAlarm =
    "detector_alarm"


earlyOn: String
earlyOn =
    "early_on"


nestCamIq: String
nestCamIq =
    "nest_cam_iq"


nestClockFarsightDigital: String
nestClockFarsightDigital =
    "nest_clock_farsight_digital"


floorLamp: String
floorLamp =
    "floor_lamp"


autoActivityZone: String
autoActivityZone =
    "auto_activity_zone"


nestMini: String
nestMini =
    "nest_mini"


homeSpeaker: String
homeSpeaker =
    "home_speaker"


autoSchedule: String
autoSchedule =
    "auto_schedule"


nestHelloDoorbell: String
nestHelloDoorbell =
    "nest_hello_doorbell"


homeMaxDots: String
homeMaxDots =
    "home_max_dots"


nestAudio: String
nestAudio =
    "nest_audio"


nestWifiRouter: String
nestWifiRouter =
    "nest_wifi_router"


houseWithShield: String
houseWithShield =
    "house_with_shield"


zonePersonUrgent: String
zonePersonUrgent =
    "zone_person_urgent"


motionSensorActive: String
motionSensorActive =
    "motion_sensor_active"


coolToDry: String
coolToDry =
    "cool_to_dry"


nestDisplayMax: String
nestDisplayMax =
    "nest_display_max"


nestFarsightWeather: String
nestFarsightWeather =
    "nest_farsight_weather"


shieldWithHouse: String
shieldWithHouse =
    "shield_with_house"


chromecast2: String
chromecast2 =
    "chromecast_2"


batteryProfile: String
batteryProfile =
    "battery_profile"


windowClosed: String
windowClosed =
    "window_closed"


heatPumpBalance: String
heatPumpBalance =
    "heat_pump_balance"


armingCountdown: String
armingCountdown =
    "arming_countdown"


nestFoundSavings: String
nestFoundSavings =
    "nest_found_savings"


selfCare: String
selfCare =
    "self_care"


batteryVert050: String
batteryVert050 =
    "battery_vert_050"


detectorStatus: String
detectorStatus =
    "detector_status"


toolsLevel: String
toolsLevel =
    "tools_level"


windowOpen: String
windowOpen =
    "window_open"


nestThermostatZirconiumEu: String
nestThermostatZirconiumEu =
    "nest_thermostat_zirconium_eu"


arrowsMoreDown: String
arrowsMoreDown =
    "arrows_more_down"


nestTrueRadiant: String
nestTrueRadiant =
    "nest_true_radiant"


zonePersonAlert: String
zonePersonAlert =
    "zone_person_alert"


nestCamWiredStand: String
nestCamWiredStand =
    "nest_cam_wired_stand"


climateMiniSplit: String
climateMiniSplit =
    "climate_mini_split"


detector: String
detector =
    "detector"


nestDetect: String
nestDetect =
    "nest_detect"


nestWifiMistral: String
nestWifiMistral =
    "nest_wifi_mistral"


nestWifiPoint: String
nestWifiPoint =
    "nest_wifi_point"


quietTime: String
quietTime =
    "quiet_time"


doorSensor: String
doorSensor =
    "door_sensor"


nestCamFloodlight: String
nestCamFloodlight =
    "nest_cam_floodlight"


nestDoorbellVisitor: String
nestDoorbellVisitor =
    "nest_doorbell_visitor"


nestTag: String
nestTag =
    "nest_tag"


toolsInstallationKit: String
toolsInstallationKit =
    "tools_installation_kit"


batteryVert020: String
batteryVert020 =
    "battery_vert_020"


nestConnect: String
nestConnect =
    "nest_connect"


batteryVert005: String
batteryVert005 =
    "battery_vert_005"


nestThermostatSensorEu: String
nestThermostatSensorEu =
    "nest_thermostat_sensor_eu"


nestThermostatSensor: String
nestThermostatSensor =
    "nest_thermostat_sensor"


toolsPhillips: String
toolsPhillips =
    "tools_phillips"


nestSunblock: String
nestSunblock =
    "nest_sunblock"


nestWifiGale: String
nestWifiGale =
    "nest_wifi_gale"


nestWifiPointVento: String
nestWifiPointVento =
    "nest_wifi_point_vento"


nestThermostatEEu: String
nestThermostatEEu =
    "nest_thermostat_e_eu"


doorbellChime: String
doorbellChime =
    "doorbell_chime"


detectorCo: String
detectorCo =
    "detector_co"


detectorBattery: String
detectorBattery =
    "detector_battery"


toolsFlatHead: String
toolsFlatHead =
    "tools_flat_head"


nestWakeOnApproach: String
nestWakeOnApproach =
    "nest_wake_on_approach"


nestWakeOnPress: String
nestWakeOnPress =
    "nest_wake_on_press"


motionSensorUrgent: String
motionSensorUrgent =
    "motion_sensor_urgent"


motionSensorAlert: String
motionSensorAlert =
    "motion_sensor_alert"


windowSensor: String
windowSensor =
    "window_sensor"


tableLamp: String
tableLamp =
    "table_lamp"


tamperDetectionOn: String
tamperDetectionOn =
    "tamper_detection_on"


nestCamMagnetMount: String
nestCamMagnetMount =
    "nest_cam_magnet_mount"


zonePersonIdle: String
zonePersonIdle =
    "zone_person_idle"


quietTimeActive: String
quietTimeActive =
    "quiet_time_active"


nestCamStand: String
nestCamStand =
    "nest_cam_stand"


detectorOffline: String
detectorOffline =
    "detector_offline"


nestCamWallMount: String
nestCamWallMount =
    "nest_cam_wall_mount"


wallLamp: String
wallLamp =
    "wall_lamp"


nestLocatorTag: String
nestLocatorTag =
    "nest_locator_tag"


motionSensorIdle: String
motionSensorIdle =
    "motion_sensor_idle"


assistantOnHub: String
assistantOnHub =
    "assistant_on_hub"


launcherAssistantOn: String
launcherAssistantOn =
    "launcher_assistant_on"


nightlightOff: String
nightlightOff =
    "nightlight_off"


bloodPressure: String
bloodPressure =
    "blood_pressure"


keyboardTabRtl: String
keyboardTabRtl =
    "keyboard_tab_rtl"


contrastRtlOff: String
contrastRtlOff =
    "contrast_rtl_off"


