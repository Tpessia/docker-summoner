import { Controller, Get, Query } from '@nestjs/common';
import { AppService } from './app.service';
import { spawn, ChildProcessWithoutNullStreams } from 'child_process';
import { ApiQuery } from '@nestjs/swagger';

@Controller('app')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @ApiQuery({ name: 'command', schema: { default: 'docker' } })
  @ApiQuery({ name: 'params', schema: { default: ['run', 'ubuntu', 'echo', '"teste"'] } })
  getHello(@Query('command') command: string = 'docker', @Query('params') params: string[] = ['run', 'ubuntu', 'echo', '"teste"']): Promise<any> {
    return new Promise<any>((res,rej) => {
      const result = {
        message: null,
        status: null,
        code: null
      }
      
      // const process = spawn('ls', ['-lh', '/usr']);
      // const process = spawn('ps');
      // const process = spawn('docker run ubuntu echo "teste"');
      // const process = spawn('docker', ['run', 'ubuntu', 'echo', '"teste"']);

      const process = spawn(command, params);
  
      process.stdout.on('data', (data: any) => {
        const msg = `stdout: ${data}`;
        console.log(msg);
        result.message = msg;
        result.status = 'success';
      });
  
      process.stderr.on('data', (data: any) => {
        const msg = `stderr: ${data}`;
        console.error(msg);
        result.message = msg;
        result.status = 'error';
      });
  
      process.on('close', (code: any) => {
        const msg = `child process exited with code ${code}`;
        console.log(msg);
        result.code = code;
        res(result)
      });
    })
  }
}
