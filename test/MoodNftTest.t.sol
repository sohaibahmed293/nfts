// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;
    string public constant HAPPY_MOOD_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0l3SURBZ01qQXdJREl3TUNJZ2QybGtkR2c5SWpRd01DSWdJR2hsYVdkb2REMGlOREF3SWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpUGdvZ0lEeGphWEpqYkdVZ1kzZzlJakV3TUNJZ1kzazlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUJ5UFNJM09DSWdjM1J5YjJ0bFBTSmliR0ZqYXlJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWk4K0NpQWdQR2NnWTJ4aGMzTTlJbVY1WlhNaVBnb2dJQ0FnUEdOcGNtTnNaU0JqZUQwaU5qRWlJR041UFNJNE1pSWdjajBpTVRJaUx6NEtJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXlOeUlnWTNrOUlqZ3lJaUJ5UFNJeE1pSXZQZ29nSUR3dlp6NEtJQ0E4Y0dGMGFDQmtQU0p0TVRNMkxqZ3hJREV4Tmk0MU0yTXVOamtnTWpZdU1UY3ROalF1TVRFZ05ESXRPREV1TlRJdExqY3pJaUJ6ZEhsc1pUMGlabWxzYkRwdWIyNWxPeUJ6ZEhKdmEyVTZJR0pzWVdOck95QnpkSEp2YTJVdGQybGtkR2c2SURNN0lpOCtDand2YzNablBnPT0ifQ==";

    string public constant SAD_MOOD_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmFwcGxpY2F0aW9uL2pzb247YmFzZTY0LGV5SnVZVzFsSWpvaVRXOXZaQ0JPUmxRaUxDQWlaR1Z6WTNKcGNIUnBiMjRpT2lKQmJpQk9SbFFnZEdoaGRDQnlaV1pzWldOMGN5QjBhR1VnYlc5dlpDQnZaaUIwYUdVZ2IzZHVaWElzSURFd01DVWdiMjRnUTJoaGFXNGhJaXdnSW1GMGRISnBZblYwWlhNaU9pQmJleUowY21GcGRGOTBlWEJsSWpvZ0ltMXZiMlJwYm1WemN5SXNJQ0oyWVd4MVpTSTZJREV3TUgxZExDQWlhVzFoWjJVaU9pSmtZWFJoT21sdFlXZGxMM04yWnl0NGJXdzdZbUZ6WlRZMExGQklUakphZVVJeVlWZFdNMUZ0T1RSUVUwbDNTVVJCWjAxcVFYZEpSRWwzVFVOSloyUXliR3RrUjJjNVNXcFJkMDFEU1dkSlIyaHNZVmRrYjJSRU1HbE9SRUYzU1dsQ05HSlhlSFZqZWpCcFlVaFNNR05FYjNaTU0yUXpaSGsxTTAxNU5YWmpiV04yVFdwQmQwMURPWHBrYldOcFVHZHZaMGxFZUdwaFdFcHFZa2RWWjFrelp6bEpha1YzVFVOSloxa3phemxKYWtWM1RVTkpaMXB0YkhOaVJEQnBaVmRXYzJKSE9UTkphVUo1VUZOSk0wOURTV2RqTTFKNVlqSjBiRkJUU21saVIwWnFZWGxKWjJNelVubGlNblJzVEZoa2NGcElVbTlRVTBsNlNXazRLME5wUVdkUVIyTm5XVEo0YUdNelRUbEpiVlkxV2xoTmFWQm5iMmRKUTBGblVFZE9jR050VG5OYVUwSnFaVVF3YVU1cVJXbEpSMDQxVUZOSk5FMXBTV2RqYWpCcFRWUkphVXg2TkV0SlEwRm5TVVI0YW1GWVNtcGlSMVZuV1RObk9VbHFSWGxPZVVsbldUTnJPVWxxWjNsSmFVSjVVRk5KZUUxcFNYWlFaMjluU1VSM2RscDZORXRKUTBFNFkwZEdNR0ZEUW10UVUwcDBUVlJOTWt4cVozaEpSRVY0VG1rME1VMHlUWFZPYW10blRXcFpkVTFVWTNST2FsRjFUVlJGWjA1RVNYUlBSRVYxVGxSSmRFeHFZM3BKYVVKNlpFaHNjMXBVTUdsYWJXeHpZa1J3ZFdJeU5XeFBlVUo2WkVoS2RtRXlWVFpKUjBweldWZE9jazk1UW5wa1NFcDJZVEpWZEdReWJHdGtSMmMyU1VSTk4wbHBPQ3REYW5kMll6TmFibEJuUFQwaWZRPT0ifQ==";

    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(SAD_MOOD_URI, HAPPY_MOOD_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.prank(USER);
        moodNft.mintNft();

        vm.prank(USER);
        moodNft.flipMood(0);

        assertEq(keccak256(abi.encodePacked(moodNft.tokenURI(0))), keccak256(abi.encodePacked(SAD_MOOD_URI)));
    }
}
