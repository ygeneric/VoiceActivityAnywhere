import definePlugin from "@utils/types";

export default definePlugin({
    name: "VoiceActivityAnywhere",
    description: "Lets you use Voice Activity in voice channels that require push to talk",
    authors: [{ name: "Paulie", id: 0n }],
    patches: [
        {
            find: "SET_VAD_PERMISSION:",
            replacement: {
                match: /(SET_VAD_PERMISSION:function\(\i\)\{let\{hasPermission:\i\}=\i,\i=)!\i/,
                replace: "$1!1"
            }
        },
        {
            find: "PermissionVADStore",
            replacement: [
                {
                    match: /shouldShowWarning\(\)\{return!\i\}/,
                    replace: "shouldShowWarning(){return!1}"
                },
                {
                    match: /canUseVoiceActivity\(\)\{return \i\}/,
                    replace: "canUseVoiceActivity(){return!0}"
                }
            ]
        }
    ]
});
