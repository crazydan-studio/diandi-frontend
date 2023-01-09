module Model.Icon exposing (Icon(..))

{-| -}


{-| Ant Design图标列表

```js
// 从 https://github.com/lemol/ant-design-icons-elm/blob/2.0.0/src/Ant/Icons/Svg.elm 获取名称列表
icons.split(', ')
    .map(function (t) {
        return t.replace(/^(.)/, function($0, $1) {
            return $1.toUpperCase();
        });
    })
    .join('\n| ')
```

-}
type Icon
    = StepBackwardOutlined
    | StepBackwardFilled
    | StepForwardOutlined
    | StepForwardFilled
    | FastBackwardOutlined
    | FastBackwardFilled
    | FastForwardOutlined
    | FastForwardFilled
    | ShrinkOutlined
    | ArrowsAltOutlined
    | DownOutlined
    | UpOutlined
    | LeftOutlined
    | RightOutlined
    | CaretUpOutlined
    | CaretUpFilled
    | CaretDownOutlined
    | CaretDownFilled
    | CaretLeftOutlined
    | CaretLeftFilled
    | CaretRightOutlined
    | CaretRightFilled
    | UpCircleOutlined
    | UpCircleFilled
    | UpCircleTwoTone
    | DownCircleOutlined
    | DownCircleFilled
    | DownCircleTwoTone
    | LeftCircleOutlined
    | LeftCircleFilled
    | LeftCircleTwoTone
    | RightCircleOutlined
    | RightCircleFilled
    | RightCircleTwoTone
    | DoubleRightOutlined
    | DoubleLeftOutlined
    | VerticalLeftOutlined
    | VerticalRightOutlined
    | VerticalAlignTopOutlined
    | VerticalAlignMiddleOutlined
    | VerticalAlignBottomOutlined
    | ForwardOutlined
    | ForwardFilled
    | BackwardOutlined
    | BackwardFilled
    | RollbackOutlined
    | EnterOutlined
    | RetweetOutlined
    | SwapOutlined
    | SwapLeftOutlined
    | SwapRightOutlined
    | ArrowUpOutlined
    | ArrowDownOutlined
    | ArrowLeftOutlined
    | ArrowRightOutlined
    | PlayCircleOutlined
    | PlayCircleFilled
    | PlayCircleTwoTone
    | UpSquareOutlined
    | UpSquareFilled
    | UpSquareTwoTone
    | DownSquareOutlined
    | DownSquareFilled
    | DownSquareTwoTone
    | LeftSquareOutlined
    | LeftSquareFilled
    | LeftSquareTwoTone
    | RightSquareOutlined
    | RightSquareFilled
    | RightSquareTwoTone
    | LoginOutlined
    | LogoutOutlined
    | MenuFoldOutlined
    | MenuUnfoldOutlined
    | BorderBottomOutlined
    | BorderHorizontalOutlined
    | BorderInnerOutlined
    | BorderOuterOutlined
    | BorderLeftOutlined
    | BorderRightOutlined
    | BorderTopOutlined
    | BorderVerticleOutlined
    | PicCenterOutlined
    | PicLeftOutlined
    | PicRightOutlined
    | RadiusBottomleftOutlined
    | RadiusBottomrightOutlined
    | RadiusUpleftOutlined
    | RadiusUprightOutlined
    | FullscreenOutlined
    | FullscreenExitOutlined
    | QuestionOutlined
    | QuestionCircleOutlined
    | QuestionCircleFilled
    | QuestionCircleTwoTone
    | PlusOutlined
    | PlusCircleOutlined
    | PlusCircleFilled
    | PlusCircleTwoTone
    | PauseOutlined
    | PauseCircleOutlined
    | PauseCircleFilled
    | PauseCircleTwoTone
    | MinusOutlined
    | MinusCircleOutlined
    | MinusCircleFilled
    | MinusCircleTwoTone
    | PlusSquareOutlined
    | PlusSquareFilled
    | PlusSquareTwoTone
    | MinusSquareOutlined
    | MinusSquareFilled
    | MinusSquareTwoTone
    | InfoOutlined
    | InfoCircleOutlined
    | InfoCircleFilled
    | InfoCircleTwoTone
    | ExclamationOutlined
    | ExclamationCircleOutlined
    | ExclamationCircleFilled
    | ExclamationCircleTwoTone
    | CloseOutlined
    | CloseCircleOutlined
    | CloseCircleFilled
    | CloseCircleTwoTone
    | CloseSquareOutlined
    | CloseSquareFilled
    | CloseSquareTwoTone
    | CheckOutlined
    | CheckCircleOutlined
    | CheckCircleFilled
    | CheckCircleTwoTone
    | CheckSquareOutlined
    | CheckSquareFilled
    | CheckSquareTwoTone
    | ClockCircleOutlined
    | ClockCircleFilled
    | ClockCircleTwoTone
    | WarningOutlined
    | WarningFilled
    | WarningTwoTone
    | IssuesCloseOutlined
    | StopOutlined
    | StopFilled
    | StopTwoTone
    | EditOutlined
    | EditFilled
    | EditTwoTone
    | FormOutlined
    | CopyOutlined
    | CopyFilled
    | CopyTwoTone
    | ScissorOutlined
    | DeleteOutlined
    | DeleteFilled
    | DeleteTwoTone
    | SnippetsOutlined
    | SnippetsFilled
    | SnippetsTwoTone
    | DiffOutlined
    | DiffFilled
    | DiffTwoTone
    | HighlightOutlined
    | HighlightFilled
    | HighlightTwoTone
    | AlignCenterOutlined
    | AlignLeftOutlined
    | AlignRightOutlined
    | BgColorsOutlined
    | BoldOutlined
    | ItalicOutlined
    | UnderlineOutlined
    | StrikethroughOutlined
    | RedoOutlined
    | UndoOutlined
    | ZoomInOutlined
    | ZoomOutOutlined
    | FontColorsOutlined
    | FontSizeOutlined
    | LineHeightOutlined
    | DashOutlined
    | SmallDashOutlined
    | SortAscendingOutlined
    | SortDescendingOutlined
    | DragOutlined
    | OrderedListOutlined
    | UnorderedListOutlined
    | RadiusSettingOutlined
    | ColumnWidthOutlined
    | ColumnHeightOutlined
    | AreaChartOutlined
    | PieChartOutlined
    | PieChartFilled
    | PieChartTwoTone
    | BarChartOutlined
    | DotChartOutlined
    | LineChartOutlined
    | RadarChartOutlined
    | HeatMapOutlined
    | FallOutlined
    | RiseOutlined
    | StockOutlined
    | BoxPlotOutlined
    | BoxPlotFilled
    | BoxPlotTwoTone
    | FundOutlined
    | FundFilled
    | FundTwoTone
    | SlidersOutlined
    | SlidersFilled
    | SlidersTwoTone
    | AndroidOutlined
    | AndroidFilled
    | AppleOutlined
    | AppleFilled
    | WindowsOutlined
    | WindowsFilled
    | IeOutlined
    | ChromeOutlined
    | ChromeFilled
    | GithubOutlined
    | GithubFilled
    | AliwangwangOutlined
    | AliwangwangFilled
    | DingdingOutlined
    | WeiboSquareOutlined
    | WeiboSquareFilled
    | WeiboCircleOutlined
    | WeiboCircleFilled
    | TaobaoCircleOutlined
    | TaobaoCircleFilled
    | Html5Outlined
    | Html5Filled
    | Html5TwoTone
    | WeiboOutlined
    | TwitterOutlined
    | WechatOutlined
    | WechatFilled
    | YoutubeOutlined
    | YoutubeFilled
    | AlipayCircleOutlined
    | AlipayCircleFilled
    | TaobaoOutlined
    | SkypeOutlined
    | SkypeFilled
    | QqOutlined
    | MediumWorkmarkOutlined
    | GitlabOutlined
    | GitlabFilled
    | MediumOutlined
    | LinkedinOutlined
    | LinkedinFilled
    | GooglePlusOutlined
    | DropboxOutlined
    | FacebookOutlined
    | FacebookFilled
    | CodepenOutlined
    | CodeSandboxOutlined
    | CodeSandboxCircleFilled
    | AmazonOutlined
    | GoogleOutlined
    | CodepenCircleOutlined
    | CodepenCircleFilled
    | AlipayOutlined
    | AntDesignOutlined
    | AntCloudOutlined
    | AliyunOutlined
    | ZhihuOutlined
    | SlackOutlined
    | SlackSquareOutlined
    | SlackSquareFilled
    | BehanceOutlined
    | BehanceSquareOutlined
    | BehanceSquareFilled
    | DribbbleOutlined
    | DribbbleSquareOutlined
    | DribbbleSquareFilled
    | InstagramOutlined
    | InstagramFilled
    | YuqueOutlined
    | YuqueFilled
    | AlibabaOutlined
    | YahooOutlined
    | YahooFilled
    | RedditOutlined
    | SketchOutlined
    | AccountBookOutlined
    | AccountBookFilled
    | AccountBookTwoTone
    | AimOutlined
    | AlertOutlined
    | AlertFilled
    | AlertTwoTone
    | AlipaySquareFilled
    | AmazonCircleFilled
    | AmazonSquareFilled
    | ApartmentOutlined
    | ApiOutlined
    | ApiFilled
    | ApiTwoTone
    | AppstoreAddOutlined
    | AppstoreOutlined
    | AppstoreFilled
    | AppstoreTwoTone
    | AudioOutlined
    | AudioFilled
    | AudioTwoTone
    | AudioMutedOutlined
    | AuditOutlined
    | BankOutlined
    | BankFilled
    | BankTwoTone
    | BarcodeOutlined
    | BarsOutlined
    | BehanceCircleFilled
    | BellOutlined
    | BellFilled
    | BellTwoTone
    | BlockOutlined
    | BookOutlined
    | BookFilled
    | BookTwoTone
    | BorderOutlined
    | BorderlessTableOutlined
    | BranchesOutlined
    | BugOutlined
    | BugFilled
    | BugTwoTone
    | BuildOutlined
    | BuildFilled
    | BuildTwoTone
    | BulbOutlined
    | BulbFilled
    | BulbTwoTone
    | CalculatorOutlined
    | CalculatorFilled
    | CalculatorTwoTone
    | CalendarOutlined
    | CalendarFilled
    | CalendarTwoTone
    | CameraOutlined
    | CameraFilled
    | CameraTwoTone
    | CarOutlined
    | CarFilled
    | CarTwoTone
    | CarryOutOutlined
    | CarryOutFilled
    | CarryOutTwoTone
    | CiCircleOutlined
    | CiCircleFilled
    | CiCircleTwoTone
    | CiOutlined
    | CiTwoTone
    | ClearOutlined
    | CloudDownloadOutlined
    | CloudOutlined
    | CloudFilled
    | CloudTwoTone
    | CloudServerOutlined
    | CloudSyncOutlined
    | CloudUploadOutlined
    | ClusterOutlined
    | CodeOutlined
    | CodeFilled
    | CodeTwoTone
    | CodeSandboxSquareFilled
    | CodepenSquareFilled
    | CoffeeOutlined
    | CommentOutlined
    | CompassOutlined
    | CompassFilled
    | CompassTwoTone
    | CompressOutlined
    | ConsoleSqlOutlined
    | ContactsOutlined
    | ContactsFilled
    | ContactsTwoTone
    | ContainerOutlined
    | ContainerFilled
    | ContainerTwoTone
    | ControlOutlined
    | ControlFilled
    | ControlTwoTone
    | CopyrightCircleOutlined
    | CopyrightCircleFilled
    | CopyrightCircleTwoTone
    | CopyrightOutlined
    | CopyrightTwoTone
    | CreditCardOutlined
    | CreditCardFilled
    | CreditCardTwoTone
    | CrownOutlined
    | CrownFilled
    | CrownTwoTone
    | CustomerServiceOutlined
    | CustomerServiceFilled
    | CustomerServiceTwoTone
    | DashboardOutlined
    | DashboardFilled
    | DashboardTwoTone
    | DatabaseOutlined
    | DatabaseFilled
    | DatabaseTwoTone
    | DeleteColumnOutlined
    | DeleteRowOutlined
    | DeliveredProcedureOutlined
    | DeploymentUnitOutlined
    | DesktopOutlined
    | DingtalkCircleFilled
    | DingtalkOutlined
    | DingtalkSquareFilled
    | DisconnectOutlined
    | DislikeOutlined
    | DislikeFilled
    | DislikeTwoTone
    | DollarCircleOutlined
    | DollarCircleFilled
    | DollarCircleTwoTone
    | DollarOutlined
    | DollarTwoTone
    | DownloadOutlined
    | DribbbleCircleFilled
    | DropboxCircleFilled
    | DropboxSquareFilled
    | EllipsisOutlined
    | EnvironmentOutlined
    | EnvironmentFilled
    | EnvironmentTwoTone
    | EuroCircleOutlined
    | EuroCircleFilled
    | EuroCircleTwoTone
    | EuroOutlined
    | EuroTwoTone
    | ExceptionOutlined
    | ExpandAltOutlined
    | ExpandOutlined
    | ExperimentOutlined
    | ExperimentFilled
    | ExperimentTwoTone
    | ExportOutlined
    | EyeOutlined
    | EyeFilled
    | EyeTwoTone
    | EyeInvisibleOutlined
    | EyeInvisibleFilled
    | EyeInvisibleTwoTone
    | FieldBinaryOutlined
    | FieldNumberOutlined
    | FieldStringOutlined
    | FieldTimeOutlined
    | FileAddOutlined
    | FileAddFilled
    | FileAddTwoTone
    | FileDoneOutlined
    | FileExcelOutlined
    | FileExcelFilled
    | FileExcelTwoTone
    | FileExclamationOutlined
    | FileExclamationFilled
    | FileExclamationTwoTone
    | FileOutlined
    | FileFilled
    | FileTwoTone
    | FileGifOutlined
    | FileImageOutlined
    | FileImageFilled
    | FileImageTwoTone
    | FileJpgOutlined
    | FileMarkdownOutlined
    | FileMarkdownFilled
    | FileMarkdownTwoTone
    | FilePdfOutlined
    | FilePdfFilled
    | FilePdfTwoTone
    | FilePptOutlined
    | FilePptFilled
    | FilePptTwoTone
    | FileProtectOutlined
    | FileSearchOutlined
    | FileSyncOutlined
    | FileTextOutlined
    | FileTextFilled
    | FileTextTwoTone
    | FileUnknownOutlined
    | FileUnknownFilled
    | FileUnknownTwoTone
    | FileWordOutlined
    | FileWordFilled
    | FileWordTwoTone
    | FileZipOutlined
    | FileZipFilled
    | FileZipTwoTone
    | FilterOutlined
    | FilterFilled
    | FilterTwoTone
    | FireOutlined
    | FireFilled
    | FireTwoTone
    | FlagOutlined
    | FlagFilled
    | FlagTwoTone
    | FolderAddOutlined
    | FolderAddFilled
    | FolderAddTwoTone
    | FolderOutlined
    | FolderFilled
    | FolderTwoTone
    | FolderOpenOutlined
    | FolderOpenFilled
    | FolderOpenTwoTone
    | FolderViewOutlined
    | ForkOutlined
    | FormatPainterOutlined
    | FormatPainterFilled
    | FrownOutlined
    | FrownFilled
    | FrownTwoTone
    | FunctionOutlined
    | FundProjectionScreenOutlined
    | FundViewOutlined
    | FunnelPlotOutlined
    | FunnelPlotFilled
    | FunnelPlotTwoTone
    | GatewayOutlined
    | GifOutlined
    | GiftOutlined
    | GiftFilled
    | GiftTwoTone
    | GlobalOutlined
    | GoldOutlined
    | GoldFilled
    | GoldTwoTone
    | GoldenFilled
    | GoogleCircleFilled
    | GooglePlusCircleFilled
    | GooglePlusSquareFilled
    | GoogleSquareFilled
    | GroupOutlined
    | HddOutlined
    | HddFilled
    | HddTwoTone
    | HeartOutlined
    | HeartFilled
    | HeartTwoTone
    | HistoryOutlined
    | HomeOutlined
    | HomeFilled
    | HomeTwoTone
    | HourglassOutlined
    | HourglassFilled
    | HourglassTwoTone
    | IdcardOutlined
    | IdcardFilled
    | IdcardTwoTone
    | IeCircleFilled
    | IeSquareFilled
    | ImportOutlined
    | InboxOutlined
    | InsertRowAboveOutlined
    | InsertRowBelowOutlined
    | InsertRowLeftOutlined
    | InsertRowRightOutlined
    | InsuranceOutlined
    | InsuranceFilled
    | InsuranceTwoTone
    | InteractionOutlined
    | InteractionFilled
    | InteractionTwoTone
    | KeyOutlined
    | LaptopOutlined
    | LayoutOutlined
    | LayoutFilled
    | LayoutTwoTone
    | LikeOutlined
    | LikeFilled
    | LikeTwoTone
    | LineOutlined
    | LinkOutlined
    | Loading3QuartersOutlined
    | LoadingOutlined
    | LockOutlined
    | LockFilled
    | LockTwoTone
    | MacCommandOutlined
    | MacCommandFilled
    | MailOutlined
    | MailFilled
    | MailTwoTone
    | ManOutlined
    | MedicineBoxOutlined
    | MedicineBoxFilled
    | MedicineBoxTwoTone
    | MediumCircleFilled
    | MediumSquareFilled
    | MehOutlined
    | MehFilled
    | MehTwoTone
    | MenuOutlined
    | MergeCellsOutlined
    | MessageOutlined
    | MessageFilled
    | MessageTwoTone
    | MobileOutlined
    | MobileFilled
    | MobileTwoTone
    | MoneyCollectOutlined
    | MoneyCollectFilled
    | MoneyCollectTwoTone
    | MonitorOutlined
    | MoreOutlined
    | NodeCollapseOutlined
    | NodeExpandOutlined
    | NodeIndexOutlined
    | NotificationOutlined
    | NotificationFilled
    | NotificationTwoTone
    | NumberOutlined
    | OneToOneOutlined
    | PaperClipOutlined
    | PartitionOutlined
    | PayCircleOutlined
    | PayCircleFilled
    | PercentageOutlined
    | PhoneOutlined
    | PhoneFilled
    | PhoneTwoTone
    | PictureOutlined
    | PictureFilled
    | PictureTwoTone
    | PlaySquareOutlined
    | PlaySquareFilled
    | PlaySquareTwoTone
    | PoundCircleOutlined
    | PoundCircleFilled
    | PoundCircleTwoTone
    | PoundOutlined
    | PoweroffOutlined
    | PrinterOutlined
    | PrinterFilled
    | PrinterTwoTone
    | ProfileOutlined
    | ProfileFilled
    | ProfileTwoTone
    | ProjectOutlined
    | ProjectFilled
    | ProjectTwoTone
    | PropertySafetyOutlined
    | PropertySafetyFilled
    | PropertySafetyTwoTone
    | PullRequestOutlined
    | PushpinOutlined
    | PushpinFilled
    | PushpinTwoTone
    | QqCircleFilled
    | QqSquareFilled
    | QrcodeOutlined
    | ReadOutlined
    | ReadFilled
    | ReconciliationOutlined
    | ReconciliationFilled
    | ReconciliationTwoTone
    | RedEnvelopeOutlined
    | RedEnvelopeFilled
    | RedEnvelopeTwoTone
    | RedditCircleFilled
    | RedditSquareFilled
    | ReloadOutlined
    | RestOutlined
    | RestFilled
    | RestTwoTone
    | RobotOutlined
    | RobotFilled
    | RocketOutlined
    | RocketFilled
    | RocketTwoTone
    | RotateLeftOutlined
    | RotateRightOutlined
    | SafetyCertificateOutlined
    | SafetyCertificateFilled
    | SafetyCertificateTwoTone
    | SafetyOutlined
    | SaveOutlined
    | SaveFilled
    | SaveTwoTone
    | ScanOutlined
    | ScheduleOutlined
    | ScheduleFilled
    | ScheduleTwoTone
    | SearchOutlined
    | SecurityScanOutlined
    | SecurityScanFilled
    | SecurityScanTwoTone
    | SelectOutlined
    | SendOutlined
    | SettingOutlined
    | SettingFilled
    | SettingTwoTone
    | ShakeOutlined
    | ShareAltOutlined
    | ShopOutlined
    | ShopFilled
    | ShopTwoTone
    | ShoppingCartOutlined
    | ShoppingOutlined
    | ShoppingFilled
    | ShoppingTwoTone
    | SignalFilled
    | SisternodeOutlined
    | SketchCircleFilled
    | SketchSquareFilled
    | SkinOutlined
    | SkinFilled
    | SkinTwoTone
    | SlackCircleFilled
    | SmileOutlined
    | SmileFilled
    | SmileTwoTone
    | SolutionOutlined
    | SoundOutlined
    | SoundFilled
    | SoundTwoTone
    | SplitCellsOutlined
    | StarOutlined
    | StarFilled
    | StarTwoTone
    | SubnodeOutlined
    | SwitcherOutlined
    | SwitcherFilled
    | SwitcherTwoTone
    | SyncOutlined
    | TableOutlined
    | TabletOutlined
    | TabletFilled
    | TabletTwoTone
    | TagOutlined
    | TagFilled
    | TagTwoTone
    | TagsOutlined
    | TagsFilled
    | TagsTwoTone
    | TaobaoSquareFilled
    | TeamOutlined
    | ThunderboltOutlined
    | ThunderboltFilled
    | ThunderboltTwoTone
    | ToTopOutlined
    | ToolOutlined
    | ToolFilled
    | ToolTwoTone
    | TrademarkCircleOutlined
    | TrademarkCircleFilled
    | TrademarkCircleTwoTone
    | TrademarkOutlined
    | TransactionOutlined
    | TranslationOutlined
    | TrophyOutlined
    | TrophyFilled
    | TrophyTwoTone
    | TwitterCircleFilled
    | TwitterSquareFilled
    | UngroupOutlined
    | UnlockOutlined
    | UnlockFilled
    | UnlockTwoTone
    | UploadOutlined
    | UsbOutlined
    | UsbFilled
    | UsbTwoTone
    | UserAddOutlined
    | UserDeleteOutlined
    | UserOutlined
    | UserSwitchOutlined
    | UsergroupAddOutlined
    | UsergroupDeleteOutlined
    | VerifiedOutlined
    | VideoCameraAddOutlined
    | VideoCameraOutlined
    | VideoCameraFilled
    | VideoCameraTwoTone
    | WalletOutlined
    | WalletFilled
    | WalletTwoTone
    | WhatsAppOutlined
    | WifiOutlined
    | WomanOutlined
    | ZhihuCircleFilled
    | ZhihuSquareFilled
