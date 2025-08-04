#!/usr/bin/env python3
from __future__ import annotations

import sys

from functools import partial
from typing import Any

from textual._on import on
from textual.app import App, ComposeResult
from textual.binding import Binding
from textual.containers import Container, Grid, Horizontal, VerticalScroll
from textual.widgets import (
    Button,
    Collapsible,
    DataTable,
    Footer,
    Header,
    Input,
    Label,
    ListItem,
    ListView,
    MarkdownViewer,
    OptionList,
    ProgressBar,
    RadioSet,
    RichLog,
    Select,
    SelectionList,
    Switch,
    TabbedContent,
    TextArea,
    Tree,
)
from textual.widgets._masked_input import MaskedInput
from textual.widgets._toggle_button import ToggleButton
from textual.widgets.option_list import Option
from textual.widgets.text_area import Selection

MAKEFILE_INITIAL = """\
include .build/common.mk

PROJECT=
"""

MAKEFILE_INCLUDES = {
    "Common": {
        "filename": "common.mk",
        "default": True
    },
    "Bash":  {
        "filename": "bash.mk"
    },
    "Docker":  {
        "filename": "docker.mk"
    },
    "Nomad":  {
        "filename": "nomad.mk"
    },
}

class ColorSample(Label):
    pass


class ChangingThemeApp(App[None]):
    CSS = """
    #buttons {
        height: 3;
        & > Button {
            width: 10;
            margin-right: 1;
        }
    }
    ThemeList {
        height: 1fr;
        width: auto;
        dock: left;
        margin-bottom: 1;
    }
    TextArea {
        height: 8;
        scrollbar-gutter: stable;
    }
    DataTable {
        height: 8;
    }
    ColorSample {
        width: 1fr;
        color: $text;
        padding: 0 1;
        &.hover-surface {
            &:hover {
                background: $surface;
            }
        }
        &.primary {
            background: $primary;
        }
        &.secondary {
            background: $secondary;
        }
        &.accent {
            background: $accent;
        }
        &.warning {
            background: $warning;
        }
        &.error {
            background: $error;
        }
        &.success {
            background: $success;
        }
        &.foreground, &.background {
            color: $foreground;
            background: $background;
        }
        &.surface {
            background: $surface;
        }
        &.panel {
            background: $panel;
        }
        &.text-primary {
            color: $text-primary;
        }
        &.text-secondary {
            color: $text-secondary;
        }
        &.text-success {
            color: $text-success;
        }
        &.text-warning {
            color: $text-warning;
        }
        &.text-error {
            color: $text-error;
        }
        &.text-accent {
            color: $text-accent;
        }
        &.text-muted {
            color: $text-muted;
        }
        &.text-disabled {
            color: $text-disabled;
        }
        &.primary-muted {
            color: $text-primary;
            background: $primary-muted;
        }
        &.secondary-muted {
            color: $text-secondary;
            background: $secondary-muted;
        }
        &.accent-muted {
            color: $text-accent;
            background: $accent-muted;
        }
        &.warning-muted {
            color: $text-warning;
            background: $warning-muted;
        }
        &.error-muted {
            color: $text-error;
            background: $error-muted;
        }
        &.success-muted {
            color: $text-success;
            background: $success-muted;
        }
    }
    ListView {
        height: auto;

    }
    Tree {
        height: 5;
    }
    MarkdownViewer {
        height: 8;
    }
    LoadingIndicator {
        height: 3;
    }
    RichLog {
        height: 4;
    }
    TabbedContent {
        width: 34;
    }
    #label-variants {
        & > Label {
            padding: 0 1;
            margin-right: 1;
        }
    }

    #palette {
        height: auto;
        grid-size: 3;
        border-bottom: solid $border;
    }
    #widget-list {
        & > OptionList {
            height: 6;
        }
        & > RadioSet {
            height: 6;
        }
    }
    #widget-list {
    }
    #widget-list > * {
        margin: 1 2;
    }
    .panel {
        background: $panel;
    }
    .no-border {
        border: none;
    }
    #menu {
        height: auto;
        width: auto;
        border: round $border;

        & OptionList {
            background: transparent;
            padding: 0;
            border: none;
        }
    }
    """

    BINDINGS = [
        Binding(
            "escape",
            "quit",
            "quit",
            tooltip="Quit without creating a project",
        ),
    ]

    def action_quit(self) -> None:
        sys.exit(0)

    def compose(self) -> ComposeResult:
        self.title = "Project Init"
        yield Header(show_clock=True, icon="✅")
        yield Input(placeholder="Project Name")
        yield Label("Makefile Types")
        yield SelectionList[int](
            *[
                (m[0], i, m[1]['default'] if 'default' in m[1] else False) for i,m in enumerate(MAKEFILE_INCLUDES.items())
            ]
        )

        yield Label("Makefile Sample")
        yield TextArea()

        with Horizontal(id="buttons"):
            yield Button.success("Create")
            yield Button.error("Cancel")

        yield Footer()

    def on_mount(self) -> None:
        self.theme = "textual-dark"
        text_area = self.query_one(TextArea)
        text_area.selection = Selection((0, 0), (1, 10))


def gen_makefile(name: str, files: list[str]) -> str:
    header = [f"include .build/{f}\n" for f in files]
    footer = f"PROJECT={name}"
    return f"{header}\n{footer}\n"


app = ChangingThemeApp()
if __name__ == "__main__":
    app.run()
