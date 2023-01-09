module Style.Icon exposing (icon)

import Ant.Icons.Svg as Icons
import Element exposing (Color, Element, html, toRgb)
import Html exposing (Html)
import Model.Icon exposing (..)
import Svg.Attributes exposing (fill, height, width)


icon :
    { size : Int
    , color : Color
    }
    -> Model.Icon.Icon
    -> Element msg
icon attr icn =
    let
        s =
            String.fromInt attr.size

        c =
            toRgb attr.color
    in
    fromIcon icn
        [ width s
        , height s

        -- Note: svg不支持rgba模式
        , fill
            ("rgb("
                ++ ([ c.red, c.green, c.blue ]
                        |> List.indexedMap
                            (\i n ->
                                (if i == 0 then
                                    ""

                                 else
                                    " "
                                )
                                    ++ String.fromFloat (n * 255)
                            )
                        |> List.foldr (++) ""
                   )
                ++ ")"
            )
        ]
        |> html


{-| 转换代码

```js
// 从 https://github.com/lemol/ant-design-icons-elm/blob/2.0.0/src/Ant/Icons/Svg.elm 获取名称列表
icons.split(', ')
    .map(function (t) {
        var i = t.replace(/^(.)/, function($0, $1) {
            return $1.toUpperCase();
        });
        return '    ' + i + ' ->\n            Icons.' + t;
    })
    .join('\n    ');
```

-}
fromIcon :
    Model.Icon.Icon
    -> (List (Html.Attribute msg) -> Html msg)
fromIcon icn =
    case icn of
        StepBackwardOutlined ->
            Icons.stepBackwardOutlined

        StepBackwardFilled ->
            Icons.stepBackwardFilled

        StepForwardOutlined ->
            Icons.stepForwardOutlined

        StepForwardFilled ->
            Icons.stepForwardFilled

        FastBackwardOutlined ->
            Icons.fastBackwardOutlined

        FastBackwardFilled ->
            Icons.fastBackwardFilled

        FastForwardOutlined ->
            Icons.fastForwardOutlined

        FastForwardFilled ->
            Icons.fastForwardFilled

        ShrinkOutlined ->
            Icons.shrinkOutlined

        ArrowsAltOutlined ->
            Icons.arrowsAltOutlined

        DownOutlined ->
            Icons.downOutlined

        UpOutlined ->
            Icons.upOutlined

        LeftOutlined ->
            Icons.leftOutlined

        RightOutlined ->
            Icons.rightOutlined

        CaretUpOutlined ->
            Icons.caretUpOutlined

        CaretUpFilled ->
            Icons.caretUpFilled

        CaretDownOutlined ->
            Icons.caretDownOutlined

        CaretDownFilled ->
            Icons.caretDownFilled

        CaretLeftOutlined ->
            Icons.caretLeftOutlined

        CaretLeftFilled ->
            Icons.caretLeftFilled

        CaretRightOutlined ->
            Icons.caretRightOutlined

        CaretRightFilled ->
            Icons.caretRightFilled

        UpCircleOutlined ->
            Icons.upCircleOutlined

        UpCircleFilled ->
            Icons.upCircleFilled

        UpCircleTwoTone ->
            Icons.upCircleTwoTone

        DownCircleOutlined ->
            Icons.downCircleOutlined

        DownCircleFilled ->
            Icons.downCircleFilled

        DownCircleTwoTone ->
            Icons.downCircleTwoTone

        LeftCircleOutlined ->
            Icons.leftCircleOutlined

        LeftCircleFilled ->
            Icons.leftCircleFilled

        LeftCircleTwoTone ->
            Icons.leftCircleTwoTone

        RightCircleOutlined ->
            Icons.rightCircleOutlined

        RightCircleFilled ->
            Icons.rightCircleFilled

        RightCircleTwoTone ->
            Icons.rightCircleTwoTone

        DoubleRightOutlined ->
            Icons.doubleRightOutlined

        DoubleLeftOutlined ->
            Icons.doubleLeftOutlined

        VerticalLeftOutlined ->
            Icons.verticalLeftOutlined

        VerticalRightOutlined ->
            Icons.verticalRightOutlined

        VerticalAlignTopOutlined ->
            Icons.verticalAlignTopOutlined

        VerticalAlignMiddleOutlined ->
            Icons.verticalAlignMiddleOutlined

        VerticalAlignBottomOutlined ->
            Icons.verticalAlignBottomOutlined

        ForwardOutlined ->
            Icons.forwardOutlined

        ForwardFilled ->
            Icons.forwardFilled

        BackwardOutlined ->
            Icons.backwardOutlined

        BackwardFilled ->
            Icons.backwardFilled

        RollbackOutlined ->
            Icons.rollbackOutlined

        EnterOutlined ->
            Icons.enterOutlined

        RetweetOutlined ->
            Icons.retweetOutlined

        SwapOutlined ->
            Icons.swapOutlined

        SwapLeftOutlined ->
            Icons.swapLeftOutlined

        SwapRightOutlined ->
            Icons.swapRightOutlined

        ArrowUpOutlined ->
            Icons.arrowUpOutlined

        ArrowDownOutlined ->
            Icons.arrowDownOutlined

        ArrowLeftOutlined ->
            Icons.arrowLeftOutlined

        ArrowRightOutlined ->
            Icons.arrowRightOutlined

        PlayCircleOutlined ->
            Icons.playCircleOutlined

        PlayCircleFilled ->
            Icons.playCircleFilled

        PlayCircleTwoTone ->
            Icons.playCircleTwoTone

        UpSquareOutlined ->
            Icons.upSquareOutlined

        UpSquareFilled ->
            Icons.upSquareFilled

        UpSquareTwoTone ->
            Icons.upSquareTwoTone

        DownSquareOutlined ->
            Icons.downSquareOutlined

        DownSquareFilled ->
            Icons.downSquareFilled

        DownSquareTwoTone ->
            Icons.downSquareTwoTone

        LeftSquareOutlined ->
            Icons.leftSquareOutlined

        LeftSquareFilled ->
            Icons.leftSquareFilled

        LeftSquareTwoTone ->
            Icons.leftSquareTwoTone

        RightSquareOutlined ->
            Icons.rightSquareOutlined

        RightSquareFilled ->
            Icons.rightSquareFilled

        RightSquareTwoTone ->
            Icons.rightSquareTwoTone

        LoginOutlined ->
            Icons.loginOutlined

        LogoutOutlined ->
            Icons.logoutOutlined

        MenuFoldOutlined ->
            Icons.menuFoldOutlined

        MenuUnfoldOutlined ->
            Icons.menuUnfoldOutlined

        BorderBottomOutlined ->
            Icons.borderBottomOutlined

        BorderHorizontalOutlined ->
            Icons.borderHorizontalOutlined

        BorderInnerOutlined ->
            Icons.borderInnerOutlined

        BorderOuterOutlined ->
            Icons.borderOuterOutlined

        BorderLeftOutlined ->
            Icons.borderLeftOutlined

        BorderRightOutlined ->
            Icons.borderRightOutlined

        BorderTopOutlined ->
            Icons.borderTopOutlined

        BorderVerticleOutlined ->
            Icons.borderVerticleOutlined

        PicCenterOutlined ->
            Icons.picCenterOutlined

        PicLeftOutlined ->
            Icons.picLeftOutlined

        PicRightOutlined ->
            Icons.picRightOutlined

        RadiusBottomleftOutlined ->
            Icons.radiusBottomleftOutlined

        RadiusBottomrightOutlined ->
            Icons.radiusBottomrightOutlined

        RadiusUpleftOutlined ->
            Icons.radiusUpleftOutlined

        RadiusUprightOutlined ->
            Icons.radiusUprightOutlined

        FullscreenOutlined ->
            Icons.fullscreenOutlined

        FullscreenExitOutlined ->
            Icons.fullscreenExitOutlined

        QuestionOutlined ->
            Icons.questionOutlined

        QuestionCircleOutlined ->
            Icons.questionCircleOutlined

        QuestionCircleFilled ->
            Icons.questionCircleFilled

        QuestionCircleTwoTone ->
            Icons.questionCircleTwoTone

        PlusOutlined ->
            Icons.plusOutlined

        PlusCircleOutlined ->
            Icons.plusCircleOutlined

        PlusCircleFilled ->
            Icons.plusCircleFilled

        PlusCircleTwoTone ->
            Icons.plusCircleTwoTone

        PauseOutlined ->
            Icons.pauseOutlined

        PauseCircleOutlined ->
            Icons.pauseCircleOutlined

        PauseCircleFilled ->
            Icons.pauseCircleFilled

        PauseCircleTwoTone ->
            Icons.pauseCircleTwoTone

        MinusOutlined ->
            Icons.minusOutlined

        MinusCircleOutlined ->
            Icons.minusCircleOutlined

        MinusCircleFilled ->
            Icons.minusCircleFilled

        MinusCircleTwoTone ->
            Icons.minusCircleTwoTone

        PlusSquareOutlined ->
            Icons.plusSquareOutlined

        PlusSquareFilled ->
            Icons.plusSquareFilled

        PlusSquareTwoTone ->
            Icons.plusSquareTwoTone

        MinusSquareOutlined ->
            Icons.minusSquareOutlined

        MinusSquareFilled ->
            Icons.minusSquareFilled

        MinusSquareTwoTone ->
            Icons.minusSquareTwoTone

        InfoOutlined ->
            Icons.infoOutlined

        InfoCircleOutlined ->
            Icons.infoCircleOutlined

        InfoCircleFilled ->
            Icons.infoCircleFilled

        InfoCircleTwoTone ->
            Icons.infoCircleTwoTone

        ExclamationOutlined ->
            Icons.exclamationOutlined

        ExclamationCircleOutlined ->
            Icons.exclamationCircleOutlined

        ExclamationCircleFilled ->
            Icons.exclamationCircleFilled

        ExclamationCircleTwoTone ->
            Icons.exclamationCircleTwoTone

        CloseOutlined ->
            Icons.closeOutlined

        CloseCircleOutlined ->
            Icons.closeCircleOutlined

        CloseCircleFilled ->
            Icons.closeCircleFilled

        CloseCircleTwoTone ->
            Icons.closeCircleTwoTone

        CloseSquareOutlined ->
            Icons.closeSquareOutlined

        CloseSquareFilled ->
            Icons.closeSquareFilled

        CloseSquareTwoTone ->
            Icons.closeSquareTwoTone

        CheckOutlined ->
            Icons.checkOutlined

        CheckCircleOutlined ->
            Icons.checkCircleOutlined

        CheckCircleFilled ->
            Icons.checkCircleFilled

        CheckCircleTwoTone ->
            Icons.checkCircleTwoTone

        CheckSquareOutlined ->
            Icons.checkSquareOutlined

        CheckSquareFilled ->
            Icons.checkSquareFilled

        CheckSquareTwoTone ->
            Icons.checkSquareTwoTone

        ClockCircleOutlined ->
            Icons.clockCircleOutlined

        ClockCircleFilled ->
            Icons.clockCircleFilled

        ClockCircleTwoTone ->
            Icons.clockCircleTwoTone

        WarningOutlined ->
            Icons.warningOutlined

        WarningFilled ->
            Icons.warningFilled

        WarningTwoTone ->
            Icons.warningTwoTone

        IssuesCloseOutlined ->
            Icons.issuesCloseOutlined

        StopOutlined ->
            Icons.stopOutlined

        StopFilled ->
            Icons.stopFilled

        StopTwoTone ->
            Icons.stopTwoTone

        EditOutlined ->
            Icons.editOutlined

        EditFilled ->
            Icons.editFilled

        EditTwoTone ->
            Icons.editTwoTone

        FormOutlined ->
            Icons.formOutlined

        CopyOutlined ->
            Icons.copyOutlined

        CopyFilled ->
            Icons.copyFilled

        CopyTwoTone ->
            Icons.copyTwoTone

        ScissorOutlined ->
            Icons.scissorOutlined

        DeleteOutlined ->
            Icons.deleteOutlined

        DeleteFilled ->
            Icons.deleteFilled

        DeleteTwoTone ->
            Icons.deleteTwoTone

        SnippetsOutlined ->
            Icons.snippetsOutlined

        SnippetsFilled ->
            Icons.snippetsFilled

        SnippetsTwoTone ->
            Icons.snippetsTwoTone

        DiffOutlined ->
            Icons.diffOutlined

        DiffFilled ->
            Icons.diffFilled

        DiffTwoTone ->
            Icons.diffTwoTone

        HighlightOutlined ->
            Icons.highlightOutlined

        HighlightFilled ->
            Icons.highlightFilled

        HighlightTwoTone ->
            Icons.highlightTwoTone

        AlignCenterOutlined ->
            Icons.alignCenterOutlined

        AlignLeftOutlined ->
            Icons.alignLeftOutlined

        AlignRightOutlined ->
            Icons.alignRightOutlined

        BgColorsOutlined ->
            Icons.bgColorsOutlined

        BoldOutlined ->
            Icons.boldOutlined

        ItalicOutlined ->
            Icons.italicOutlined

        UnderlineOutlined ->
            Icons.underlineOutlined

        StrikethroughOutlined ->
            Icons.strikethroughOutlined

        RedoOutlined ->
            Icons.redoOutlined

        UndoOutlined ->
            Icons.undoOutlined

        ZoomInOutlined ->
            Icons.zoomInOutlined

        ZoomOutOutlined ->
            Icons.zoomOutOutlined

        FontColorsOutlined ->
            Icons.fontColorsOutlined

        FontSizeOutlined ->
            Icons.fontSizeOutlined

        LineHeightOutlined ->
            Icons.lineHeightOutlined

        DashOutlined ->
            Icons.dashOutlined

        SmallDashOutlined ->
            Icons.smallDashOutlined

        SortAscendingOutlined ->
            Icons.sortAscendingOutlined

        SortDescendingOutlined ->
            Icons.sortDescendingOutlined

        DragOutlined ->
            Icons.dragOutlined

        OrderedListOutlined ->
            Icons.orderedListOutlined

        UnorderedListOutlined ->
            Icons.unorderedListOutlined

        RadiusSettingOutlined ->
            Icons.radiusSettingOutlined

        ColumnWidthOutlined ->
            Icons.columnWidthOutlined

        ColumnHeightOutlined ->
            Icons.columnHeightOutlined

        AreaChartOutlined ->
            Icons.areaChartOutlined

        PieChartOutlined ->
            Icons.pieChartOutlined

        PieChartFilled ->
            Icons.pieChartFilled

        PieChartTwoTone ->
            Icons.pieChartTwoTone

        BarChartOutlined ->
            Icons.barChartOutlined

        DotChartOutlined ->
            Icons.dotChartOutlined

        LineChartOutlined ->
            Icons.lineChartOutlined

        RadarChartOutlined ->
            Icons.radarChartOutlined

        HeatMapOutlined ->
            Icons.heatMapOutlined

        FallOutlined ->
            Icons.fallOutlined

        RiseOutlined ->
            Icons.riseOutlined

        StockOutlined ->
            Icons.stockOutlined

        BoxPlotOutlined ->
            Icons.boxPlotOutlined

        BoxPlotFilled ->
            Icons.boxPlotFilled

        BoxPlotTwoTone ->
            Icons.boxPlotTwoTone

        FundOutlined ->
            Icons.fundOutlined

        FundFilled ->
            Icons.fundFilled

        FundTwoTone ->
            Icons.fundTwoTone

        SlidersOutlined ->
            Icons.slidersOutlined

        SlidersFilled ->
            Icons.slidersFilled

        SlidersTwoTone ->
            Icons.slidersTwoTone

        AndroidOutlined ->
            Icons.androidOutlined

        AndroidFilled ->
            Icons.androidFilled

        AppleOutlined ->
            Icons.appleOutlined

        AppleFilled ->
            Icons.appleFilled

        WindowsOutlined ->
            Icons.windowsOutlined

        WindowsFilled ->
            Icons.windowsFilled

        IeOutlined ->
            Icons.ieOutlined

        ChromeOutlined ->
            Icons.chromeOutlined

        ChromeFilled ->
            Icons.chromeFilled

        GithubOutlined ->
            Icons.githubOutlined

        GithubFilled ->
            Icons.githubFilled

        AliwangwangOutlined ->
            Icons.aliwangwangOutlined

        AliwangwangFilled ->
            Icons.aliwangwangFilled

        DingdingOutlined ->
            Icons.dingdingOutlined

        WeiboSquareOutlined ->
            Icons.weiboSquareOutlined

        WeiboSquareFilled ->
            Icons.weiboSquareFilled

        WeiboCircleOutlined ->
            Icons.weiboCircleOutlined

        WeiboCircleFilled ->
            Icons.weiboCircleFilled

        TaobaoCircleOutlined ->
            Icons.taobaoCircleOutlined

        TaobaoCircleFilled ->
            Icons.taobaoCircleFilled

        Html5Outlined ->
            Icons.html5Outlined

        Html5Filled ->
            Icons.html5Filled

        Html5TwoTone ->
            Icons.html5TwoTone

        WeiboOutlined ->
            Icons.weiboOutlined

        TwitterOutlined ->
            Icons.twitterOutlined

        WechatOutlined ->
            Icons.wechatOutlined

        WechatFilled ->
            Icons.wechatFilled

        YoutubeOutlined ->
            Icons.youtubeOutlined

        YoutubeFilled ->
            Icons.youtubeFilled

        AlipayCircleOutlined ->
            Icons.alipayCircleOutlined

        AlipayCircleFilled ->
            Icons.alipayCircleFilled

        TaobaoOutlined ->
            Icons.taobaoOutlined

        SkypeOutlined ->
            Icons.skypeOutlined

        SkypeFilled ->
            Icons.skypeFilled

        QqOutlined ->
            Icons.qqOutlined

        MediumWorkmarkOutlined ->
            Icons.mediumWorkmarkOutlined

        GitlabOutlined ->
            Icons.gitlabOutlined

        GitlabFilled ->
            Icons.gitlabFilled

        MediumOutlined ->
            Icons.mediumOutlined

        LinkedinOutlined ->
            Icons.linkedinOutlined

        LinkedinFilled ->
            Icons.linkedinFilled

        GooglePlusOutlined ->
            Icons.googlePlusOutlined

        DropboxOutlined ->
            Icons.dropboxOutlined

        FacebookOutlined ->
            Icons.facebookOutlined

        FacebookFilled ->
            Icons.facebookFilled

        CodepenOutlined ->
            Icons.codepenOutlined

        CodeSandboxOutlined ->
            Icons.codeSandboxOutlined

        CodeSandboxCircleFilled ->
            Icons.codeSandboxCircleFilled

        AmazonOutlined ->
            Icons.amazonOutlined

        GoogleOutlined ->
            Icons.googleOutlined

        CodepenCircleOutlined ->
            Icons.codepenCircleOutlined

        CodepenCircleFilled ->
            Icons.codepenCircleFilled

        AlipayOutlined ->
            Icons.alipayOutlined

        AntDesignOutlined ->
            Icons.antDesignOutlined

        AntCloudOutlined ->
            Icons.antCloudOutlined

        AliyunOutlined ->
            Icons.aliyunOutlined

        ZhihuOutlined ->
            Icons.zhihuOutlined

        SlackOutlined ->
            Icons.slackOutlined

        SlackSquareOutlined ->
            Icons.slackSquareOutlined

        SlackSquareFilled ->
            Icons.slackSquareFilled

        BehanceOutlined ->
            Icons.behanceOutlined

        BehanceSquareOutlined ->
            Icons.behanceSquareOutlined

        BehanceSquareFilled ->
            Icons.behanceSquareFilled

        DribbbleOutlined ->
            Icons.dribbbleOutlined

        DribbbleSquareOutlined ->
            Icons.dribbbleSquareOutlined

        DribbbleSquareFilled ->
            Icons.dribbbleSquareFilled

        InstagramOutlined ->
            Icons.instagramOutlined

        InstagramFilled ->
            Icons.instagramFilled

        YuqueOutlined ->
            Icons.yuqueOutlined

        YuqueFilled ->
            Icons.yuqueFilled

        AlibabaOutlined ->
            Icons.alibabaOutlined

        YahooOutlined ->
            Icons.yahooOutlined

        YahooFilled ->
            Icons.yahooFilled

        RedditOutlined ->
            Icons.redditOutlined

        SketchOutlined ->
            Icons.sketchOutlined

        AccountBookOutlined ->
            Icons.accountBookOutlined

        AccountBookFilled ->
            Icons.accountBookFilled

        AccountBookTwoTone ->
            Icons.accountBookTwoTone

        AimOutlined ->
            Icons.aimOutlined

        AlertOutlined ->
            Icons.alertOutlined

        AlertFilled ->
            Icons.alertFilled

        AlertTwoTone ->
            Icons.alertTwoTone

        AlipaySquareFilled ->
            Icons.alipaySquareFilled

        AmazonCircleFilled ->
            Icons.amazonCircleFilled

        AmazonSquareFilled ->
            Icons.amazonSquareFilled

        ApartmentOutlined ->
            Icons.apartmentOutlined

        ApiOutlined ->
            Icons.apiOutlined

        ApiFilled ->
            Icons.apiFilled

        ApiTwoTone ->
            Icons.apiTwoTone

        AppstoreAddOutlined ->
            Icons.appstoreAddOutlined

        AppstoreOutlined ->
            Icons.appstoreOutlined

        AppstoreFilled ->
            Icons.appstoreFilled

        AppstoreTwoTone ->
            Icons.appstoreTwoTone

        AudioOutlined ->
            Icons.audioOutlined

        AudioFilled ->
            Icons.audioFilled

        AudioTwoTone ->
            Icons.audioTwoTone

        AudioMutedOutlined ->
            Icons.audioMutedOutlined

        AuditOutlined ->
            Icons.auditOutlined

        BankOutlined ->
            Icons.bankOutlined

        BankFilled ->
            Icons.bankFilled

        BankTwoTone ->
            Icons.bankTwoTone

        BarcodeOutlined ->
            Icons.barcodeOutlined

        BarsOutlined ->
            Icons.barsOutlined

        BehanceCircleFilled ->
            Icons.behanceCircleFilled

        BellOutlined ->
            Icons.bellOutlined

        BellFilled ->
            Icons.bellFilled

        BellTwoTone ->
            Icons.bellTwoTone

        BlockOutlined ->
            Icons.blockOutlined

        BookOutlined ->
            Icons.bookOutlined

        BookFilled ->
            Icons.bookFilled

        BookTwoTone ->
            Icons.bookTwoTone

        BorderOutlined ->
            Icons.borderOutlined

        BorderlessTableOutlined ->
            Icons.borderlessTableOutlined

        BranchesOutlined ->
            Icons.branchesOutlined

        BugOutlined ->
            Icons.bugOutlined

        BugFilled ->
            Icons.bugFilled

        BugTwoTone ->
            Icons.bugTwoTone

        BuildOutlined ->
            Icons.buildOutlined

        BuildFilled ->
            Icons.buildFilled

        BuildTwoTone ->
            Icons.buildTwoTone

        BulbOutlined ->
            Icons.bulbOutlined

        BulbFilled ->
            Icons.bulbFilled

        BulbTwoTone ->
            Icons.bulbTwoTone

        CalculatorOutlined ->
            Icons.calculatorOutlined

        CalculatorFilled ->
            Icons.calculatorFilled

        CalculatorTwoTone ->
            Icons.calculatorTwoTone

        CalendarOutlined ->
            Icons.calendarOutlined

        CalendarFilled ->
            Icons.calendarFilled

        CalendarTwoTone ->
            Icons.calendarTwoTone

        CameraOutlined ->
            Icons.cameraOutlined

        CameraFilled ->
            Icons.cameraFilled

        CameraTwoTone ->
            Icons.cameraTwoTone

        CarOutlined ->
            Icons.carOutlined

        CarFilled ->
            Icons.carFilled

        CarTwoTone ->
            Icons.carTwoTone

        CarryOutOutlined ->
            Icons.carryOutOutlined

        CarryOutFilled ->
            Icons.carryOutFilled

        CarryOutTwoTone ->
            Icons.carryOutTwoTone

        CiCircleOutlined ->
            Icons.ciCircleOutlined

        CiCircleFilled ->
            Icons.ciCircleFilled

        CiCircleTwoTone ->
            Icons.ciCircleTwoTone

        CiOutlined ->
            Icons.ciOutlined

        CiTwoTone ->
            Icons.ciTwoTone

        ClearOutlined ->
            Icons.clearOutlined

        CloudDownloadOutlined ->
            Icons.cloudDownloadOutlined

        CloudOutlined ->
            Icons.cloudOutlined

        CloudFilled ->
            Icons.cloudFilled

        CloudTwoTone ->
            Icons.cloudTwoTone

        CloudServerOutlined ->
            Icons.cloudServerOutlined

        CloudSyncOutlined ->
            Icons.cloudSyncOutlined

        CloudUploadOutlined ->
            Icons.cloudUploadOutlined

        ClusterOutlined ->
            Icons.clusterOutlined

        CodeOutlined ->
            Icons.codeOutlined

        CodeFilled ->
            Icons.codeFilled

        CodeTwoTone ->
            Icons.codeTwoTone

        CodeSandboxSquareFilled ->
            Icons.codeSandboxSquareFilled

        CodepenSquareFilled ->
            Icons.codepenSquareFilled

        CoffeeOutlined ->
            Icons.coffeeOutlined

        CommentOutlined ->
            Icons.commentOutlined

        CompassOutlined ->
            Icons.compassOutlined

        CompassFilled ->
            Icons.compassFilled

        CompassTwoTone ->
            Icons.compassTwoTone

        CompressOutlined ->
            Icons.compressOutlined

        ConsoleSqlOutlined ->
            Icons.consoleSqlOutlined

        ContactsOutlined ->
            Icons.contactsOutlined

        ContactsFilled ->
            Icons.contactsFilled

        ContactsTwoTone ->
            Icons.contactsTwoTone

        ContainerOutlined ->
            Icons.containerOutlined

        ContainerFilled ->
            Icons.containerFilled

        ContainerTwoTone ->
            Icons.containerTwoTone

        ControlOutlined ->
            Icons.controlOutlined

        ControlFilled ->
            Icons.controlFilled

        ControlTwoTone ->
            Icons.controlTwoTone

        CopyrightCircleOutlined ->
            Icons.copyrightCircleOutlined

        CopyrightCircleFilled ->
            Icons.copyrightCircleFilled

        CopyrightCircleTwoTone ->
            Icons.copyrightCircleTwoTone

        CopyrightOutlined ->
            Icons.copyrightOutlined

        CopyrightTwoTone ->
            Icons.copyrightTwoTone

        CreditCardOutlined ->
            Icons.creditCardOutlined

        CreditCardFilled ->
            Icons.creditCardFilled

        CreditCardTwoTone ->
            Icons.creditCardTwoTone

        CrownOutlined ->
            Icons.crownOutlined

        CrownFilled ->
            Icons.crownFilled

        CrownTwoTone ->
            Icons.crownTwoTone

        CustomerServiceOutlined ->
            Icons.customerServiceOutlined

        CustomerServiceFilled ->
            Icons.customerServiceFilled

        CustomerServiceTwoTone ->
            Icons.customerServiceTwoTone

        DashboardOutlined ->
            Icons.dashboardOutlined

        DashboardFilled ->
            Icons.dashboardFilled

        DashboardTwoTone ->
            Icons.dashboardTwoTone

        DatabaseOutlined ->
            Icons.databaseOutlined

        DatabaseFilled ->
            Icons.databaseFilled

        DatabaseTwoTone ->
            Icons.databaseTwoTone

        DeleteColumnOutlined ->
            Icons.deleteColumnOutlined

        DeleteRowOutlined ->
            Icons.deleteRowOutlined

        DeliveredProcedureOutlined ->
            Icons.deliveredProcedureOutlined

        DeploymentUnitOutlined ->
            Icons.deploymentUnitOutlined

        DesktopOutlined ->
            Icons.desktopOutlined

        DingtalkCircleFilled ->
            Icons.dingtalkCircleFilled

        DingtalkOutlined ->
            Icons.dingtalkOutlined

        DingtalkSquareFilled ->
            Icons.dingtalkSquareFilled

        DisconnectOutlined ->
            Icons.disconnectOutlined

        DislikeOutlined ->
            Icons.dislikeOutlined

        DislikeFilled ->
            Icons.dislikeFilled

        DislikeTwoTone ->
            Icons.dislikeTwoTone

        DollarCircleOutlined ->
            Icons.dollarCircleOutlined

        DollarCircleFilled ->
            Icons.dollarCircleFilled

        DollarCircleTwoTone ->
            Icons.dollarCircleTwoTone

        DollarOutlined ->
            Icons.dollarOutlined

        DollarTwoTone ->
            Icons.dollarTwoTone

        DownloadOutlined ->
            Icons.downloadOutlined

        DribbbleCircleFilled ->
            Icons.dribbbleCircleFilled

        DropboxCircleFilled ->
            Icons.dropboxCircleFilled

        DropboxSquareFilled ->
            Icons.dropboxSquareFilled

        EllipsisOutlined ->
            Icons.ellipsisOutlined

        EnvironmentOutlined ->
            Icons.environmentOutlined

        EnvironmentFilled ->
            Icons.environmentFilled

        EnvironmentTwoTone ->
            Icons.environmentTwoTone

        EuroCircleOutlined ->
            Icons.euroCircleOutlined

        EuroCircleFilled ->
            Icons.euroCircleFilled

        EuroCircleTwoTone ->
            Icons.euroCircleTwoTone

        EuroOutlined ->
            Icons.euroOutlined

        EuroTwoTone ->
            Icons.euroTwoTone

        ExceptionOutlined ->
            Icons.exceptionOutlined

        ExpandAltOutlined ->
            Icons.expandAltOutlined

        ExpandOutlined ->
            Icons.expandOutlined

        ExperimentOutlined ->
            Icons.experimentOutlined

        ExperimentFilled ->
            Icons.experimentFilled

        ExperimentTwoTone ->
            Icons.experimentTwoTone

        ExportOutlined ->
            Icons.exportOutlined

        EyeOutlined ->
            Icons.eyeOutlined

        EyeFilled ->
            Icons.eyeFilled

        EyeTwoTone ->
            Icons.eyeTwoTone

        EyeInvisibleOutlined ->
            Icons.eyeInvisibleOutlined

        EyeInvisibleFilled ->
            Icons.eyeInvisibleFilled

        EyeInvisibleTwoTone ->
            Icons.eyeInvisibleTwoTone

        FieldBinaryOutlined ->
            Icons.fieldBinaryOutlined

        FieldNumberOutlined ->
            Icons.fieldNumberOutlined

        FieldStringOutlined ->
            Icons.fieldStringOutlined

        FieldTimeOutlined ->
            Icons.fieldTimeOutlined

        FileAddOutlined ->
            Icons.fileAddOutlined

        FileAddFilled ->
            Icons.fileAddFilled

        FileAddTwoTone ->
            Icons.fileAddTwoTone

        FileDoneOutlined ->
            Icons.fileDoneOutlined

        FileExcelOutlined ->
            Icons.fileExcelOutlined

        FileExcelFilled ->
            Icons.fileExcelFilled

        FileExcelTwoTone ->
            Icons.fileExcelTwoTone

        FileExclamationOutlined ->
            Icons.fileExclamationOutlined

        FileExclamationFilled ->
            Icons.fileExclamationFilled

        FileExclamationTwoTone ->
            Icons.fileExclamationTwoTone

        FileOutlined ->
            Icons.fileOutlined

        FileFilled ->
            Icons.fileFilled

        FileTwoTone ->
            Icons.fileTwoTone

        FileGifOutlined ->
            Icons.fileGifOutlined

        FileImageOutlined ->
            Icons.fileImageOutlined

        FileImageFilled ->
            Icons.fileImageFilled

        FileImageTwoTone ->
            Icons.fileImageTwoTone

        FileJpgOutlined ->
            Icons.fileJpgOutlined

        FileMarkdownOutlined ->
            Icons.fileMarkdownOutlined

        FileMarkdownFilled ->
            Icons.fileMarkdownFilled

        FileMarkdownTwoTone ->
            Icons.fileMarkdownTwoTone

        FilePdfOutlined ->
            Icons.filePdfOutlined

        FilePdfFilled ->
            Icons.filePdfFilled

        FilePdfTwoTone ->
            Icons.filePdfTwoTone

        FilePptOutlined ->
            Icons.filePptOutlined

        FilePptFilled ->
            Icons.filePptFilled

        FilePptTwoTone ->
            Icons.filePptTwoTone

        FileProtectOutlined ->
            Icons.fileProtectOutlined

        FileSearchOutlined ->
            Icons.fileSearchOutlined

        FileSyncOutlined ->
            Icons.fileSyncOutlined

        FileTextOutlined ->
            Icons.fileTextOutlined

        FileTextFilled ->
            Icons.fileTextFilled

        FileTextTwoTone ->
            Icons.fileTextTwoTone

        FileUnknownOutlined ->
            Icons.fileUnknownOutlined

        FileUnknownFilled ->
            Icons.fileUnknownFilled

        FileUnknownTwoTone ->
            Icons.fileUnknownTwoTone

        FileWordOutlined ->
            Icons.fileWordOutlined

        FileWordFilled ->
            Icons.fileWordFilled

        FileWordTwoTone ->
            Icons.fileWordTwoTone

        FileZipOutlined ->
            Icons.fileZipOutlined

        FileZipFilled ->
            Icons.fileZipFilled

        FileZipTwoTone ->
            Icons.fileZipTwoTone

        FilterOutlined ->
            Icons.filterOutlined

        FilterFilled ->
            Icons.filterFilled

        FilterTwoTone ->
            Icons.filterTwoTone

        FireOutlined ->
            Icons.fireOutlined

        FireFilled ->
            Icons.fireFilled

        FireTwoTone ->
            Icons.fireTwoTone

        FlagOutlined ->
            Icons.flagOutlined

        FlagFilled ->
            Icons.flagFilled

        FlagTwoTone ->
            Icons.flagTwoTone

        FolderAddOutlined ->
            Icons.folderAddOutlined

        FolderAddFilled ->
            Icons.folderAddFilled

        FolderAddTwoTone ->
            Icons.folderAddTwoTone

        FolderOutlined ->
            Icons.folderOutlined

        FolderFilled ->
            Icons.folderFilled

        FolderTwoTone ->
            Icons.folderTwoTone

        FolderOpenOutlined ->
            Icons.folderOpenOutlined

        FolderOpenFilled ->
            Icons.folderOpenFilled

        FolderOpenTwoTone ->
            Icons.folderOpenTwoTone

        FolderViewOutlined ->
            Icons.folderViewOutlined

        ForkOutlined ->
            Icons.forkOutlined

        FormatPainterOutlined ->
            Icons.formatPainterOutlined

        FormatPainterFilled ->
            Icons.formatPainterFilled

        FrownOutlined ->
            Icons.frownOutlined

        FrownFilled ->
            Icons.frownFilled

        FrownTwoTone ->
            Icons.frownTwoTone

        FunctionOutlined ->
            Icons.functionOutlined

        FundProjectionScreenOutlined ->
            Icons.fundProjectionScreenOutlined

        FundViewOutlined ->
            Icons.fundViewOutlined

        FunnelPlotOutlined ->
            Icons.funnelPlotOutlined

        FunnelPlotFilled ->
            Icons.funnelPlotFilled

        FunnelPlotTwoTone ->
            Icons.funnelPlotTwoTone

        GatewayOutlined ->
            Icons.gatewayOutlined

        GifOutlined ->
            Icons.gifOutlined

        GiftOutlined ->
            Icons.giftOutlined

        GiftFilled ->
            Icons.giftFilled

        GiftTwoTone ->
            Icons.giftTwoTone

        GlobalOutlined ->
            Icons.globalOutlined

        GoldOutlined ->
            Icons.goldOutlined

        GoldFilled ->
            Icons.goldFilled

        GoldTwoTone ->
            Icons.goldTwoTone

        GoldenFilled ->
            Icons.goldenFilled

        GoogleCircleFilled ->
            Icons.googleCircleFilled

        GooglePlusCircleFilled ->
            Icons.googlePlusCircleFilled

        GooglePlusSquareFilled ->
            Icons.googlePlusSquareFilled

        GoogleSquareFilled ->
            Icons.googleSquareFilled

        GroupOutlined ->
            Icons.groupOutlined

        HddOutlined ->
            Icons.hddOutlined

        HddFilled ->
            Icons.hddFilled

        HddTwoTone ->
            Icons.hddTwoTone

        HeartOutlined ->
            Icons.heartOutlined

        HeartFilled ->
            Icons.heartFilled

        HeartTwoTone ->
            Icons.heartTwoTone

        HistoryOutlined ->
            Icons.historyOutlined

        HomeOutlined ->
            Icons.homeOutlined

        HomeFilled ->
            Icons.homeFilled

        HomeTwoTone ->
            Icons.homeTwoTone

        HourglassOutlined ->
            Icons.hourglassOutlined

        HourglassFilled ->
            Icons.hourglassFilled

        HourglassTwoTone ->
            Icons.hourglassTwoTone

        IdcardOutlined ->
            Icons.idcardOutlined

        IdcardFilled ->
            Icons.idcardFilled

        IdcardTwoTone ->
            Icons.idcardTwoTone

        IeCircleFilled ->
            Icons.ieCircleFilled

        IeSquareFilled ->
            Icons.ieSquareFilled

        ImportOutlined ->
            Icons.importOutlined

        InboxOutlined ->
            Icons.inboxOutlined

        InsertRowAboveOutlined ->
            Icons.insertRowAboveOutlined

        InsertRowBelowOutlined ->
            Icons.insertRowBelowOutlined

        InsertRowLeftOutlined ->
            Icons.insertRowLeftOutlined

        InsertRowRightOutlined ->
            Icons.insertRowRightOutlined

        InsuranceOutlined ->
            Icons.insuranceOutlined

        InsuranceFilled ->
            Icons.insuranceFilled

        InsuranceTwoTone ->
            Icons.insuranceTwoTone

        InteractionOutlined ->
            Icons.interactionOutlined

        InteractionFilled ->
            Icons.interactionFilled

        InteractionTwoTone ->
            Icons.interactionTwoTone

        KeyOutlined ->
            Icons.keyOutlined

        LaptopOutlined ->
            Icons.laptopOutlined

        LayoutOutlined ->
            Icons.layoutOutlined

        LayoutFilled ->
            Icons.layoutFilled

        LayoutTwoTone ->
            Icons.layoutTwoTone

        LikeOutlined ->
            Icons.likeOutlined

        LikeFilled ->
            Icons.likeFilled

        LikeTwoTone ->
            Icons.likeTwoTone

        LineOutlined ->
            Icons.lineOutlined

        LinkOutlined ->
            Icons.linkOutlined

        Loading3QuartersOutlined ->
            Icons.loading3QuartersOutlined

        LoadingOutlined ->
            Icons.loadingOutlined

        LockOutlined ->
            Icons.lockOutlined

        LockFilled ->
            Icons.lockFilled

        LockTwoTone ->
            Icons.lockTwoTone

        MacCommandOutlined ->
            Icons.macCommandOutlined

        MacCommandFilled ->
            Icons.macCommandFilled

        MailOutlined ->
            Icons.mailOutlined

        MailFilled ->
            Icons.mailFilled

        MailTwoTone ->
            Icons.mailTwoTone

        ManOutlined ->
            Icons.manOutlined

        MedicineBoxOutlined ->
            Icons.medicineBoxOutlined

        MedicineBoxFilled ->
            Icons.medicineBoxFilled

        MedicineBoxTwoTone ->
            Icons.medicineBoxTwoTone

        MediumCircleFilled ->
            Icons.mediumCircleFilled

        MediumSquareFilled ->
            Icons.mediumSquareFilled

        MehOutlined ->
            Icons.mehOutlined

        MehFilled ->
            Icons.mehFilled

        MehTwoTone ->
            Icons.mehTwoTone

        MenuOutlined ->
            Icons.menuOutlined

        MergeCellsOutlined ->
            Icons.mergeCellsOutlined

        MessageOutlined ->
            Icons.messageOutlined

        MessageFilled ->
            Icons.messageFilled

        MessageTwoTone ->
            Icons.messageTwoTone

        MobileOutlined ->
            Icons.mobileOutlined

        MobileFilled ->
            Icons.mobileFilled

        MobileTwoTone ->
            Icons.mobileTwoTone

        MoneyCollectOutlined ->
            Icons.moneyCollectOutlined

        MoneyCollectFilled ->
            Icons.moneyCollectFilled

        MoneyCollectTwoTone ->
            Icons.moneyCollectTwoTone

        MonitorOutlined ->
            Icons.monitorOutlined

        MoreOutlined ->
            Icons.moreOutlined

        NodeCollapseOutlined ->
            Icons.nodeCollapseOutlined

        NodeExpandOutlined ->
            Icons.nodeExpandOutlined

        NodeIndexOutlined ->
            Icons.nodeIndexOutlined

        NotificationOutlined ->
            Icons.notificationOutlined

        NotificationFilled ->
            Icons.notificationFilled

        NotificationTwoTone ->
            Icons.notificationTwoTone

        NumberOutlined ->
            Icons.numberOutlined

        OneToOneOutlined ->
            Icons.oneToOneOutlined

        PaperClipOutlined ->
            Icons.paperClipOutlined

        PartitionOutlined ->
            Icons.partitionOutlined

        PayCircleOutlined ->
            Icons.payCircleOutlined

        PayCircleFilled ->
            Icons.payCircleFilled

        PercentageOutlined ->
            Icons.percentageOutlined

        PhoneOutlined ->
            Icons.phoneOutlined

        PhoneFilled ->
            Icons.phoneFilled

        PhoneTwoTone ->
            Icons.phoneTwoTone

        PictureOutlined ->
            Icons.pictureOutlined

        PictureFilled ->
            Icons.pictureFilled

        PictureTwoTone ->
            Icons.pictureTwoTone

        PlaySquareOutlined ->
            Icons.playSquareOutlined

        PlaySquareFilled ->
            Icons.playSquareFilled

        PlaySquareTwoTone ->
            Icons.playSquareTwoTone

        PoundCircleOutlined ->
            Icons.poundCircleOutlined

        PoundCircleFilled ->
            Icons.poundCircleFilled

        PoundCircleTwoTone ->
            Icons.poundCircleTwoTone

        PoundOutlined ->
            Icons.poundOutlined

        PoweroffOutlined ->
            Icons.poweroffOutlined

        PrinterOutlined ->
            Icons.printerOutlined

        PrinterFilled ->
            Icons.printerFilled

        PrinterTwoTone ->
            Icons.printerTwoTone

        ProfileOutlined ->
            Icons.profileOutlined

        ProfileFilled ->
            Icons.profileFilled

        ProfileTwoTone ->
            Icons.profileTwoTone

        ProjectOutlined ->
            Icons.projectOutlined

        ProjectFilled ->
            Icons.projectFilled

        ProjectTwoTone ->
            Icons.projectTwoTone

        PropertySafetyOutlined ->
            Icons.propertySafetyOutlined

        PropertySafetyFilled ->
            Icons.propertySafetyFilled

        PropertySafetyTwoTone ->
            Icons.propertySafetyTwoTone

        PullRequestOutlined ->
            Icons.pullRequestOutlined

        PushpinOutlined ->
            Icons.pushpinOutlined

        PushpinFilled ->
            Icons.pushpinFilled

        PushpinTwoTone ->
            Icons.pushpinTwoTone

        QqCircleFilled ->
            Icons.qqCircleFilled

        QqSquareFilled ->
            Icons.qqSquareFilled

        QrcodeOutlined ->
            Icons.qrcodeOutlined

        ReadOutlined ->
            Icons.readOutlined

        ReadFilled ->
            Icons.readFilled

        ReconciliationOutlined ->
            Icons.reconciliationOutlined

        ReconciliationFilled ->
            Icons.reconciliationFilled

        ReconciliationTwoTone ->
            Icons.reconciliationTwoTone

        RedEnvelopeOutlined ->
            Icons.redEnvelopeOutlined

        RedEnvelopeFilled ->
            Icons.redEnvelopeFilled

        RedEnvelopeTwoTone ->
            Icons.redEnvelopeTwoTone

        RedditCircleFilled ->
            Icons.redditCircleFilled

        RedditSquareFilled ->
            Icons.redditSquareFilled

        ReloadOutlined ->
            Icons.reloadOutlined

        RestOutlined ->
            Icons.restOutlined

        RestFilled ->
            Icons.restFilled

        RestTwoTone ->
            Icons.restTwoTone

        RobotOutlined ->
            Icons.robotOutlined

        RobotFilled ->
            Icons.robotFilled

        RocketOutlined ->
            Icons.rocketOutlined

        RocketFilled ->
            Icons.rocketFilled

        RocketTwoTone ->
            Icons.rocketTwoTone

        RotateLeftOutlined ->
            Icons.rotateLeftOutlined

        RotateRightOutlined ->
            Icons.rotateRightOutlined

        SafetyCertificateOutlined ->
            Icons.safetyCertificateOutlined

        SafetyCertificateFilled ->
            Icons.safetyCertificateFilled

        SafetyCertificateTwoTone ->
            Icons.safetyCertificateTwoTone

        SafetyOutlined ->
            Icons.safetyOutlined

        SaveOutlined ->
            Icons.saveOutlined

        SaveFilled ->
            Icons.saveFilled

        SaveTwoTone ->
            Icons.saveTwoTone

        ScanOutlined ->
            Icons.scanOutlined

        ScheduleOutlined ->
            Icons.scheduleOutlined

        ScheduleFilled ->
            Icons.scheduleFilled

        ScheduleTwoTone ->
            Icons.scheduleTwoTone

        SearchOutlined ->
            Icons.searchOutlined

        SecurityScanOutlined ->
            Icons.securityScanOutlined

        SecurityScanFilled ->
            Icons.securityScanFilled

        SecurityScanTwoTone ->
            Icons.securityScanTwoTone

        SelectOutlined ->
            Icons.selectOutlined

        SendOutlined ->
            Icons.sendOutlined

        SettingOutlined ->
            Icons.settingOutlined

        SettingFilled ->
            Icons.settingFilled

        SettingTwoTone ->
            Icons.settingTwoTone

        ShakeOutlined ->
            Icons.shakeOutlined

        ShareAltOutlined ->
            Icons.shareAltOutlined

        ShopOutlined ->
            Icons.shopOutlined

        ShopFilled ->
            Icons.shopFilled

        ShopTwoTone ->
            Icons.shopTwoTone

        ShoppingCartOutlined ->
            Icons.shoppingCartOutlined

        ShoppingOutlined ->
            Icons.shoppingOutlined

        ShoppingFilled ->
            Icons.shoppingFilled

        ShoppingTwoTone ->
            Icons.shoppingTwoTone

        SignalFilled ->
            Icons.signalFilled

        SisternodeOutlined ->
            Icons.sisternodeOutlined

        SketchCircleFilled ->
            Icons.sketchCircleFilled

        SketchSquareFilled ->
            Icons.sketchSquareFilled

        SkinOutlined ->
            Icons.skinOutlined

        SkinFilled ->
            Icons.skinFilled

        SkinTwoTone ->
            Icons.skinTwoTone

        SlackCircleFilled ->
            Icons.slackCircleFilled

        SmileOutlined ->
            Icons.smileOutlined

        SmileFilled ->
            Icons.smileFilled

        SmileTwoTone ->
            Icons.smileTwoTone

        SolutionOutlined ->
            Icons.solutionOutlined

        SoundOutlined ->
            Icons.soundOutlined

        SoundFilled ->
            Icons.soundFilled

        SoundTwoTone ->
            Icons.soundTwoTone

        SplitCellsOutlined ->
            Icons.splitCellsOutlined

        StarOutlined ->
            Icons.starOutlined

        StarFilled ->
            Icons.starFilled

        StarTwoTone ->
            Icons.starTwoTone

        SubnodeOutlined ->
            Icons.subnodeOutlined

        SwitcherOutlined ->
            Icons.switcherOutlined

        SwitcherFilled ->
            Icons.switcherFilled

        SwitcherTwoTone ->
            Icons.switcherTwoTone

        SyncOutlined ->
            Icons.syncOutlined

        TableOutlined ->
            Icons.tableOutlined

        TabletOutlined ->
            Icons.tabletOutlined

        TabletFilled ->
            Icons.tabletFilled

        TabletTwoTone ->
            Icons.tabletTwoTone

        TagOutlined ->
            Icons.tagOutlined

        TagFilled ->
            Icons.tagFilled

        TagTwoTone ->
            Icons.tagTwoTone

        TagsOutlined ->
            Icons.tagsOutlined

        TagsFilled ->
            Icons.tagsFilled

        TagsTwoTone ->
            Icons.tagsTwoTone

        TaobaoSquareFilled ->
            Icons.taobaoSquareFilled

        TeamOutlined ->
            Icons.teamOutlined

        ThunderboltOutlined ->
            Icons.thunderboltOutlined

        ThunderboltFilled ->
            Icons.thunderboltFilled

        ThunderboltTwoTone ->
            Icons.thunderboltTwoTone

        ToTopOutlined ->
            Icons.toTopOutlined

        ToolOutlined ->
            Icons.toolOutlined

        ToolFilled ->
            Icons.toolFilled

        ToolTwoTone ->
            Icons.toolTwoTone

        TrademarkCircleOutlined ->
            Icons.trademarkCircleOutlined

        TrademarkCircleFilled ->
            Icons.trademarkCircleFilled

        TrademarkCircleTwoTone ->
            Icons.trademarkCircleTwoTone

        TrademarkOutlined ->
            Icons.trademarkOutlined

        TransactionOutlined ->
            Icons.transactionOutlined

        TranslationOutlined ->
            Icons.translationOutlined

        TrophyOutlined ->
            Icons.trophyOutlined

        TrophyFilled ->
            Icons.trophyFilled

        TrophyTwoTone ->
            Icons.trophyTwoTone

        TwitterCircleFilled ->
            Icons.twitterCircleFilled

        TwitterSquareFilled ->
            Icons.twitterSquareFilled

        UngroupOutlined ->
            Icons.ungroupOutlined

        UnlockOutlined ->
            Icons.unlockOutlined

        UnlockFilled ->
            Icons.unlockFilled

        UnlockTwoTone ->
            Icons.unlockTwoTone

        UploadOutlined ->
            Icons.uploadOutlined

        UsbOutlined ->
            Icons.usbOutlined

        UsbFilled ->
            Icons.usbFilled

        UsbTwoTone ->
            Icons.usbTwoTone

        UserAddOutlined ->
            Icons.userAddOutlined

        UserDeleteOutlined ->
            Icons.userDeleteOutlined

        UserOutlined ->
            Icons.userOutlined

        UserSwitchOutlined ->
            Icons.userSwitchOutlined

        UsergroupAddOutlined ->
            Icons.usergroupAddOutlined

        UsergroupDeleteOutlined ->
            Icons.usergroupDeleteOutlined

        VerifiedOutlined ->
            Icons.verifiedOutlined

        VideoCameraAddOutlined ->
            Icons.videoCameraAddOutlined

        VideoCameraOutlined ->
            Icons.videoCameraOutlined

        VideoCameraFilled ->
            Icons.videoCameraFilled

        VideoCameraTwoTone ->
            Icons.videoCameraTwoTone

        WalletOutlined ->
            Icons.walletOutlined

        WalletFilled ->
            Icons.walletFilled

        WalletTwoTone ->
            Icons.walletTwoTone

        WhatsAppOutlined ->
            Icons.whatsAppOutlined

        WifiOutlined ->
            Icons.wifiOutlined

        WomanOutlined ->
            Icons.womanOutlined

        ZhihuCircleFilled ->
            Icons.zhihuCircleFilled

        ZhihuSquareFilled ->
            Icons.zhihuSquareFilled
