import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { JunodService } from './junod.service';
import { MegaMenuModule } from 'primeng/megamenu';
import { MegaMenuItem } from 'primeng/api';
import { Terminal, TerminalModule, TerminalService } from 'primeng/terminal';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, MegaMenuModule, TerminalModule],
  providers: [TerminalService],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent implements OnInit {
  items: MegaMenuItem[] | undefined;

  data: any;

  @ViewChild('terminal') terminal!: Terminal;

  subscription!: Subscription;

  private _commandResult: string = '';
  public get commandResult(): string {
    return this._commandResult;
  }
  public set commandResult(value: string) {
    this._commandResult = value;
    console.log('a enviar ');
    this.terminalService.sendResponse(this._commandResult);
  }

  constructor(
    private junodService: JunodService,
    private terminalService: TerminalService,
    private changeDetectorRef: ChangeDetectorRef
  ) {}
  ngOnInit(): void {
    /*  this.junodService.getJunodBase().subscribe((data) => {
      console.log(data);
      //data.message.replace('/n', '<br>');
      this.data = data;
    }); */
    this.subscription = this.terminalService.commandHandler.subscribe(
      async (command) => {
        if (command === 'junod') {
          //this.terminalService.sendResponse('Ok');
          const res = await this.junodService.getJunodBase().toPromise();
          if (res === undefined) {
            this.terminalService.sendResponse('Unknown command: ' + command);
            return;
          }
          this.data = res.result;
          this.commandResult = res.result;
          this.terminal.cd.detectChanges();
        } else {
          this.terminalService.sendResponse('Unknown command: ' + command);
        }
        /* let response =
          command === 'junod'
            ? new Date().toDateString()
            : 'Unknown command: ' + command;
        this.terminalService.sendResponse(response); */
      }
    );
  }
}
